using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace DW_ETL_Example
{
    public partial class FormExtractLoad : Form
    {
        MySqlConnection myConnOLTP;
        MySqlCommand myCmdOLTP = new MySqlCommand(); 

        MySqlConnection myConnOLAP;
        MySqlCommand myCmdOLAP = new MySqlCommand();
        MySqlDataAdapter myAdapter;
        DataTable dt;
        string originOLTP;
        bool statConnOLTP = false;
        bool statConnOLAP = false;

        public FormExtractLoad()
        {
            InitializeComponent();
        }

        private void FormExtractLoad_Load(object sender, EventArgs e)
        {
            disconnectedOLTPComponent();
            disconnectedOLAPComponent();
        }

        private void btnConnectOLTP_Click(object sender, EventArgs e)
        {
            connToSelectedOLTP(tbUserOLTP.Text, tbPassOLTP.Text, cbDBNameOLTP.Text);
            connectedOLTPComponent();
        }

        private void btnDiscOLTP_Click(object sender, EventArgs e)
        {
            disconnectedOLTPComponent();
            statConnOLTP = false;
            MessageBox.Show("Koneksi DATABASE LOCAL / OLTP DIPUTUS!");
            myConnOLTP.Close();
        }

        private void connectedOLTPComponent()
        {
            cbDBNameOLTP.Enabled = false;
            tbUserOLTP.Enabled = false;
            tbPassOLTP.Enabled = false;
            btnConnectOLTP.Enabled = false;
            btnDiscOLTP.Enabled = true;
            btnExtract.Enabled = true;
            cbTable.Enabled = true;
            dgvExtractedData.DataSource = null;
            dgvExtractedData.Refresh();
            dgvExtractedData.Enabled = true;
            lblStatOLTP.Text = "Status OLTP : Connected";
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
        }

        private void disconnectedOLTPComponent()
        {
            cbDBNameOLTP.SelectedIndex = 0;
            cbDBNameOLTP.Enabled = true;
            tbUserOLTP.Enabled = true;
            tbPassOLTP.Enabled = true;
            btnDiscOLTP.Enabled = false;
            btnConnectOLTP.Enabled = true;
            cbTable.SelectedIndex = 0;
            cbTable.Enabled = false;
            btnTL.Enabled = false;
            btnExtract.Enabled = false;
            dgvExtractedData.DataSource = null;
            dgvExtractedData.Refresh();
            dgvExtractedData.Enabled = false;
            lblStatOLTP.Text = "Status OLTP : Disconnected";
            dgvExtractedData.DataSource = null;
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
        }

        private void connToSelectedOLTP(string user, string pass, string db_name)
        {
            try
            {
                myConnOLTP = new MySqlConnection("SERVER=127.0.0.1;PORT=3306;UID=" + user + ";PASSWORD=" + pass + ";DATABASE=" + db_name);

                if (myConnOLTP.State == ConnectionState.Closed)
                {
                    myConnOLTP.Open();
                    MessageBox.Show("Berhasil TERKONEKSI ke DATABASE LOCAL / OLTP");
                    statConnOLTP = true;
                    lblStatOLTP.Text = "Status OLTP : Connected";
                }
                else if (myConnOLTP.State == ConnectionState.Open)
                {
                    MessageBox.Show("Koneksi masih TERBUKA");
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
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
                    statConnOLAP = true;
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

        private void cbTable_SelectedIndexChanged(object sender, EventArgs e)
        {
            dgvExtractedData.DataSource = null;
            btnTL.Enabled = false;
        }

        private void btnExtract_Click(object sender, EventArgs e)
        {
            extractData(cbTable.Text);
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
        }

        private void extractData(string tb_name)
        {
            try
            {
                string cmdText;
                if (tb_name.ToLower() == "transaksi")
                {
                    cmdText = "select ID_TRANS, ID_CUST, TANGGAL, TOTAL, STATUS_DEL, is_warehouse FROM " + tb_name + " WHERE is_warehouse = 0 ORDER BY 1;";
                    myAdapter = new MySqlDataAdapter(cmdText, myConnOLTP);
                    dt = new DataTable();
                    myAdapter.Fill(dt);
                    dgvExtractedData.DataSource = dt;
                    dgvExtractedData.Refresh();
                }
                else
                {
                    cmdText = "SELECT * FROM " + tb_name + " WHERE is_warehouse = 0 ORDER BY 1;";
                    myAdapter = new MySqlDataAdapter(cmdText, myConnOLTP);
                    dt = new DataTable();
                    myAdapter.Fill(dt);
                    dgvExtractedData.DataSource = dt;
                    dgvExtractedData.Refresh();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void btnConnectOLAP_Click(object sender, EventArgs e)
        {
            connToOLAPDB(tbHostOLAP.Text, tbUserOLAP.Text, tbPassOLAP.Text, tbDBNameOLAP.Text);
            connectedOLAPComponent();
        }

        private void btnDiscOLAP_Click(object sender, EventArgs e)
        {
            disconnectedOLAPComponent();
            statConnOLAP = false;
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
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
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
            dgvExtractedData.DataSource = null;
            if (statConnOLTP && statConnOLAP && cbTable.SelectedIndex != 0)
                btnTL.Enabled = true;
            else
                btnTL.Enabled = false;
        }

        private void btnTL_Click(object sender, EventArgs e)
        {
            if (cbDBNameOLTP.Text == "romand_database") originOLTP = "Romand";
            else if (cbDBNameOLTP.Text == "dior_database") originOLTP = "Dior";
            else if (cbDBNameOLTP.Text == "pinkflash_database") originOLTP = "Pinkflash";

            if (cbTable.Text.Equals("customer"))
            {
                loadCustomer();
            }
            else if (cbTable.Text.Equals("transaksi"))
            {
                loadTransaksi();
            }
            else if (cbTable.Text.Equals("detail_produk"))
            {
                loadDetailProduk();
            }
            else if (cbTable.Text.Equals("detail_transaksi"))
            {
                loadDetailTransaksi();
            }
            btnExtract_Click(sender, e);
        }

        private void loadCustomer()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO customer (ID_CUST, EMAIL, NAME, PHONE, ADDRESS, PASSWORD_HASH, STATUS_DEL, CustOrigin) VALUES ('" +
                                    dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" +
                                    dt.Rows[i][3].ToString() + "','" + dt.Rows[i][4].ToString() + "','" + dt.Rows[i][5].ToString() + "','" +
                                    dt.Rows[i][6].ToString() + "','" + originOLTP + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE customer SET is_warehouse = 1 WHERE ID_CUST='" + dt.Rows[i][0].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();
                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table " + cbTable.Text);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void loadTransaksi()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;

                // Prepare the INSERT command with parameters
                string insertCommandText = "INSERT INTO transaksi (ID_TRANS, ID_CUST, TANGGAL, TOTAL, STATUS_DEL, TransOrigin) VALUES (@ID_TRANS, @ID_CUST, @TANGGAL, @TOTAL, @STATUS_DEL, @TransOrigin)";
                myCmdOLAP.CommandText = insertCommandText;

                // Prepare the UPDATE command with parameters
                string updateCommandText = "UPDATE transaksi SET is_warehouse = 1 WHERE ID_TRANS = @ID_TRANS";
                myCmdOLTP.CommandText = updateCommandText;

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    // Clear parameters
                    myCmdOLAP.Parameters.Clear();
                    myCmdOLTP.Parameters.Clear();

                    // Add parameters for INSERT command
                    myCmdOLAP.Parameters.AddWithValue("@ID_TRANS", dt.Rows[i][0].ToString());
                    myCmdOLAP.Parameters.AddWithValue("@ID_CUST", dt.Rows[i][1].ToString());

                    // Convert the date string to a DateTime object
                    DateTime tanggal;
                    if (DateTime.TryParse(dt.Rows[i][2].ToString(), out tanggal))
                    {
                        myCmdOLAP.Parameters.AddWithValue("@TANGGAL", tanggal);
                    }
                    else
                    {
                        throw new Exception("Invalid date format");
                    }

                    myCmdOLAP.Parameters.AddWithValue("@TOTAL", dt.Rows[i][3].ToString());
                    myCmdOLAP.Parameters.AddWithValue("@STATUS_DEL", dt.Rows[i][4].ToString());
                    myCmdOLAP.Parameters.AddWithValue("@TransOrigin", originOLTP);

                    myCmdOLAP.ExecuteNonQuery();

                    // Add parameter for UPDATE command
                    myCmdOLTP.Parameters.AddWithValue("@ID_TRANS", dt.Rows[i][0].ToString());
                    myCmdOLTP.ExecuteNonQuery();
                }

                MessageBox.Show("Berhasil LOAD DATA ke DW utk table transaksi");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
        private void loadDetailProduk()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO detail_produk (ID_PROD, NAMA_PROD, SHADE, DESKRIPSI, HARGA, DISKON, KATEGORI, STOCK, STATUS_DEL, FOTO_PROD, ProdOrigin) VALUES ('" +
                                            dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" +
                                            dt.Rows[i][3].ToString() + "','" + dt.Rows[i][4].ToString() + "','" + dt.Rows[i][5].ToString() + "','" +
                                            dt.Rows[i][6].ToString() + "','" + dt.Rows[i][7].ToString() + "','" + dt.Rows[i][8].ToString() + "','" +
                                            dt.Rows[i][9].ToString() + "','" + originOLTP + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE detail_produk SET is_warehouse = 1 WHERE ID_PROD='" + dt.Rows[i][0].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();
                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table detail_produk");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }

        private void loadDetailTransaksi()
        {
            try
            {
                myCmdOLTP.Connection = myConnOLTP;
                myCmdOLAP.Connection = myConnOLAP;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    myCmdOLAP.CommandText = "INSERT INTO detail_transaksi (ID_TRANS, ID_PROD, HARGA, QTY, STATUS_DEL) VALUES ('" +
                                            dt.Rows[i][0].ToString() + "','" + dt.Rows[i][1].ToString() + "','" + dt.Rows[i][2].ToString() + "','" +
                                            dt.Rows[i][3].ToString() + "','" + dt.Rows[i][4].ToString() + "')";
                    myCmdOLAP.ExecuteNonQuery();

                    myCmdOLTP.CommandText = "UPDATE detail_transaksi SET is_warehouse = 1 WHERE ID_TRANS='" + dt.Rows[i][0].ToString() + "' AND ID_PROD='" + dt.Rows[i][1].ToString() + "';";
                    myCmdOLTP.ExecuteNonQuery();
                }
                MessageBox.Show("Berhasil LOAD DATA ke DW utk table detail_transaksi");
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
        private void FormExtractLoad_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (myConnOLTP != null)
                if (myConnOLTP.State == ConnectionState.Open) myConnOLTP.Close();
            if (myConnOLAP != null)
                if (myConnOLAP.State == ConnectionState.Open) myConnOLAP.Close();
        }
    }
}
