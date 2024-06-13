using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace DW_ETL_Example
{
    public partial class FormTransform : Form
    {
        MySqlConnection myConnOLAP;
        MySqlCommand myCmdOLAP = new MySqlCommand();
        MySqlDataAdapter myAdapter;
        DataTable dt;

        public FormTransform()
        {
            InitializeComponent();
        }

        private void btnConnectOLAP_Click(object sender, EventArgs e)
        {
            connToOLAPDB(tbHostOLAP.Text, tbUserOLAP.Text, tbPassOLAP.Text, tbDBNameOLAP.Text);
            connectedOLAPComponent();
        }

        private void btnDiscOLAP_Click(object sender, EventArgs e)
        {
            disconnectedOLAPComponent();
            MessageBox.Show("Koneksi DATA WAREHOUSE / OLAP DIPUTUS!");
            myConnOLAP.Close();
        }

        private void connectedOLAPComponent()
        {
            tbHostOLAP.Enabled = false;
            tbDBNameOLAP.Enabled = false;
            tbUserOLAP.Enabled = false;
            tbPassOLAP.Enabled = false;
            btnConnectOLAP.Enabled = false;
            btnDiscOLAP.Enabled = true;
            btnTransform.Enabled = true;
            lblStatOLAP.Text = "Status OLAP : Connected";
            showFactTable();
        }

        private void disconnectedOLAPComponent()
        {
            tbHostOLAP.Enabled = true;
            tbDBNameOLAP.Enabled = true;
            tbUserOLAP.Enabled = true;
            tbPassOLAP.Enabled = true;
            btnConnectOLAP.Enabled = true;
            btnDiscOLAP.Enabled = false;
            btnTransform.Enabled = false;
            lblStatOLAP.Text = "Status OLAP : Disconnected";
        }

        private void connToOLAPDB(string host, string user, string pass, string db_name)
        {
            try
            {
                myConnOLAP = new MySqlConnection("SERVER=" + host + ";PORT=3306;UID=" + user + ";PASSWORD=" + pass + ";DATABASE=" + db_name);

                if (myConnOLAP.State == ConnectionState.Closed)
                {
                    myConnOLAP.Open();
                    MessageBox.Show("Berhasil TERKONEKSI ke DATA WAREHOUSE (" + host + ")");
                    lblStatOLAP.Text = "Status OLAP : Connected";
                }
                else if (myConnOLAP.State == ConnectionState.Open)
                {
                    MessageBox.Show("Koneksi masih TERBUKA");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void FormTransform_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (myConnOLAP != null)
                if (myConnOLAP.State == ConnectionState.Open) myConnOLAP.Close();
        }

        private void btnTransform_Click(object sender, EventArgs e)
        {
            try
            {
                myCmdOLAP.Connection = myConnOLAP;
                string cmdText = "SELECT t.ID_TRANS, p.ID_PROD, DATE_FORMAT(t.TANGGAL, '%Y-%m-%d') AS TANGGAL, t.TransOrigin, t.ID_CUST, p.HARGA, p.DISKON, dt.QTY " +
                                 "FROM detail_transaksi dt " +
                                 "JOIN transaksi t ON dt.ID_TRANS = t.ID_TRANS " +
                                 "JOIN detail_produk p ON dt.ID_PROD = p.ID_PROD " +
                                 "WHERE dt.IS_FACT = 0;"; 
                myAdapter = new MySqlDataAdapter(cmdText, myConnOLAP);
                dt = new DataTable();
                myAdapter.Fill(dt);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO sales_fact (ID_TRANS, ID_PROD, TANGGAL, TransOrigin, ID_CUST, HARGA, DISKON, QTY) VALUES " +
                                            "('" + dt.Rows[i]["ID_TRANS"].ToString() + "','" + dt.Rows[i]["ID_PROD"].ToString() + "','" + dt.Rows[i]["TANGGAL"].ToString() + "','" +
                                            dt.Rows[i]["TransOrigin"].ToString() + "','" + dt.Rows[i]["ID_CUST"].ToString() + "','" + dt.Rows[i]["HARGA"].ToString() + "','" +
                                            dt.Rows[i]["DISKON"].ToString() + "','" + dt.Rows[i]["QTY"].ToString() + "')";
                    myCmdOLAP.ExecuteNonQuery();
                }
                myCmdOLAP.CommandText = "UPDATE detail_transaksi SET IS_FACT = 1 WHERE IS_FACT = 0;";
                myCmdOLAP.ExecuteNonQuery();

                showFactTable();
                MessageBox.Show("Berhasil Membuat FACT TABLE");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void showFactTable()
        {
            try
            {
                myAdapter = new MySqlDataAdapter("SELECT SALES_ID, ID_TRANS, DATE_FORMAT(TANGGAL, '%Y-%m-%d') AS TANGGAL, TransOrigin, ID_CUST, ID_PROD, QTY, HARGA, DISKON " +
                    "FROM sales_fact " +
                    "ORDER BY SALES_ID DESC;", myConnOLAP);
                dt = new DataTable();
                myAdapter.Fill(dt);
                dgvFactTable.DataSource = dt;
                dgvFactTable.Refresh();
            } catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void FormTransform_Load(object sender, EventArgs e)
        {
            disconnectedOLAPComponent();
        }
    }
}
