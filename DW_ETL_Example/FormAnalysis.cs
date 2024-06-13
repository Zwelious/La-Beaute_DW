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
using OxyPlot.Wpf;

namespace DW_ETL_Example
{
    public partial class FormAnalysis : Form
    {
        MySqlConnection myConnOLAP;
        MySqlCommand myCmdOLAP = new MySqlCommand();
        MySqlDataAdapter myAdapter;
        DataTable dt;

        public FormAnalysis()
        {
            InitializeComponent();
        }

        private void FormAnalysis_Load(object sender, EventArgs e)
        {
            cbReport1.SelectedIndex = 3;
            disconnectedOLAPComponent();
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
            lblStatOLAP.Text = "Status OLAP : Connected";
        }

        private void disconnectedOLAPComponent()
        {
            tbHostOLAP.Enabled = true;
            tbDBNameOLAP.Enabled = true;
            tbUserOLAP.Enabled = true;
            tbPassOLAP.Enabled = true;
            btnConnectOLAP.Enabled = true;
            btnDiscOLAP.Enabled = false;
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

        private void FormAnalysis_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (myConnOLAP != null)
                if (myConnOLAP.State == ConnectionState.Open) myConnOLAP.Close();
        }

        private void btnReport1_Click(object sender, EventArgs e)
        {
            try
            {
                string cmdText = "";

                switch (cbReport1.SelectedIndex)
                {
                    case 0: // All customers
                        cmdText = "SELECT ID_CUST AS CustomerName, COUNT(*) AS PurchaseFreq FROM sales_fact GROUP BY ID_CUST";
                        break;
                    case 1: // Dior
                        cmdText = "SELECT S.TransOrigin AS Brand, COUNT(*) AS PurchaseFreq " +
                                  "FROM sales_fact S " +
                                  "INNER JOIN detail_produk D ON S.ID_PROD = D.ID_PROD " +
                                  "WHERE S.TransOrigin = 'Dior' " +
                                  "GROUP BY S.TransOrigin";
                        break;
                    case 2: // Pinkflash
                        cmdText = "SELECT S.TransOrigin AS Brand, COUNT(*) AS PurchaseFreq " +
                                  "FROM sales_fact S " +
                                  "INNER JOIN detail_produk D ON S.ID_PROD = D.ID_PROD " +
                                  "WHERE S.TransOrigin = 'Pinkflash' " +
                                  "GROUP BY S.TransOrigin";
                        break;
                    case 3: // Romand
                        cmdText = "SELECT S.TransOrigin AS Brand, COUNT(*) AS PurchaseFreq " +
                                  "FROM sales_fact S " +
                                  "INNER JOIN detail_produk D ON S.ID_PROD = D.ID_PROD " +
                                  "WHERE S.TransOrigin = 'Romand' " +
                                  "GROUP BY S.TransOrigin";
                        break;
                    default:
                        break;
                }

                if (!string.IsNullOrEmpty(cmdText))
                {
                    using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmdText, myConnOLAP))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        dgvResult.DataSource = dt;
                        dgvResult.Refresh();

                        chart1.DataSource = dt;
                        chart1.Series[0].Name = "Purchase Frequency";
                        chart1.Series[0].XValueMember = "Brand"; // X-axis value member for brand names
                        chart1.Series[0].YValueMembers = "PurchaseFreq";
                        chart1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void btnReport2_Click(object sender, EventArgs e)
        {
            try
            {
                string cmdText = "SELECT * FROM ProductSales";

                using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmdText, myConnOLAP))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    dgvResult.DataSource = dt;
                    dgvResult.Refresh();

                    chart1.DataSource = dt;
                    chart1.Series[0].Name = "Total Sold";
                    chart1.Series[0].XValueMember = "NAMA_PROD"; 
                    chart1.Series[0].YValueMembers = "TotalSales";
                    chart1.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void btnReport3_Click(object sender, EventArgs e)
        {
            try
            {
                string cmdText = "SELECT * FROM MonthlySales";

                using (MySqlDataAdapter adapter = new MySqlDataAdapter(cmdText, myConnOLAP))
                {
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    dgvResult.DataSource = dt;
                    dgvResult.Refresh();

                    chart1.DataSource = dt;
                    chart1.Series[0].Name = "Total Sales";
                    chart1.Series[0].XValueMember = "Month"; // Assuming you want to display month and year together
                    chart1.Series[0].YValueMembers = "TotalSales";
                    chart1.DataBind();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
    }
}
