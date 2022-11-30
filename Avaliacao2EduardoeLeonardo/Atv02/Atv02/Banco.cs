using System;
using System.Data;
using System.Data.SqlClient;

namespace Atv02
{
    internal class Banco
    {
        private string user = "usuario";
        private string password = "senha1234";
        private string db = "";
        private string dataSource = "";
        private string conec = "";


        private SqlConnection cn;

        public global::System.String User { get => user; set => user = value; }
        public global::System.String Password { get => password; set => password = value; }
        public string Db { get => db; set => db = value; }
        public string DataSource { get => dataSource; set => dataSource = value; }

        private void conexao()
        {
            conec = "Data Source=" + dataSource +
            ";Initial Catalog=" + db + ";" + "User ID=" +
            user + ";password =" +
            password + ";" +
            "Language=Portuguese";

            cn = new SqlConnection(conec);
        }

        public SqlConnection abrirConexao()
        {
            try
            {
                conexao();
                cn.Open();
                return cn;
            }
            catch (Exception e)
            {
                return null;
            }

        }

        public void fecharConexao()
        {
            try
            {
                cn.Close();
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public DataTable executaConsulta(string sql)
        {
            try
            {
                abrirConexao();
                SqlCommand comando = new SqlCommand(sql, cn);
                comando.ExecuteNonQuery();
                SqlDataAdapter adapter = new SqlDataAdapter(comando);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
            catch (Exception ex)
            {
                return null;
            }
            finally
            {
                fecharConexao();
            }
        }
    }
}
