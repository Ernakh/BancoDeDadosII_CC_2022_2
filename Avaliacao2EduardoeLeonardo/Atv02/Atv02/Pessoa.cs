using System;
using System.Data;
using System.Data.SqlClient;

namespace Atv02
{
    internal class Pessoa
    {
        public int id;
        public string nome;
        public int idade;
        public int altura;

        public bool gravarPessoa()
        {
            Banco bd = new Banco();
            SqlConnection cn = bd.abrirConexao();

            SqlTransaction transacao = cn.BeginTransaction();
            SqlCommand comando = new SqlCommand();

            comando.Connection = cn;
            comando.Transaction = transacao;
            comando.CommandType = CommandType.Text;
            comando.CommandText = "insert into pessoas values()" +
                    " (@nome, @idade, @altura)";
            comando.Parameters.Add("@nome", SqlDbType.VarChar);
            comando.Parameters.Add("@idade", SqlDbType.Int);
            comando.Parameters.Add("@altura", SqlDbType.Int);
            comando.Parameters[0].Value = nome;
            comando.Parameters[1].Value = idade;
            comando.Parameters[2].Value = altura;

            try
            {
                comando.ExecuteNonQuery();
                transacao.Commit();
                return true;
            }
            catch (Exception)
            {
                transacao.Rollback();
                return false;
            }
            finally
            {
                bd.fecharConexao();
            }
        }
    }
}
