using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace Atv02
{
    internal class Usuario
    {
        public int id;
        public string usuario;
        public string password;
        public string banco;

        public Usuario(string usuario, string password, string banco)
        {
            this.usuario = usuario;
            this.password = password;
            this.banco = banco;
        }

        public Usuario()
        {
        }

        public void executarTransacao(SqlCommand comando, SqlTransaction transacao)
        {
            try
            {
                comando.ExecuteNonQuery();
                transacao.Commit();
            }
            catch (Exception ex)
            {
                transacao.Rollback();
            }
        }

        public bool gravarUsuario()
        {
            try
            {
                primeiroComando();
                segundoComando();
                terceiroComando();
                return true;
            }catch(Exception e)
            {
                return false;
            }

        }
        public bool primeiroComando()
        {
            Banco bd = new Banco();
            bd.Db = banco;
            SqlConnection cn = bd.abrirConexao();
            SqlTransaction transacao = cn.BeginTransaction();

            SqlCommand comando1 = new SqlCommand();

            comando1.Connection = cn;
            comando1.Transaction = transacao;
            comando1.CommandType = CommandType.Text;

            comando1.CommandText = "create login " + usuario + " with password='" + password + "';";
            try
            {
                comando1.ExecuteNonQuery();
                transacao.Commit();
                return true;
            }
            catch (Exception ex)
            {
                transacao.Rollback();
                return false;
            }
            finally
            {
                bd.fecharConexao();
            }

        }

        public bool segundoComando()
        {
            Banco bd = new Banco();
            bd.Db = banco;
            SqlConnection cn = bd.abrirConexao();
            SqlTransaction transacao = cn.BeginTransaction();

            SqlCommand comando2 = new SqlCommand();

            comando2.Connection = cn;
            comando2.Transaction = transacao;
            comando2.CommandType = CommandType.Text;

            comando2.CommandText = "create user " + usuario + " from login " + usuario + ";";
            try
            {
                comando2.ExecuteNonQuery();
                transacao.Commit();
                return true;
            }
            catch (Exception ex)
            {
                transacao.Rollback();
                return false;
            }
            finally
            {
                bd.fecharConexao();
            }

        }

        public bool terceiroComando()
        {
            Banco bd = new Banco();
            bd.Db = banco;
            SqlConnection cn = bd.abrirConexao();
            SqlTransaction transacao = cn.BeginTransaction();

            SqlCommand comando3 = new SqlCommand();

            comando3.Connection = cn;
            comando3.Transaction = transacao;
            comando3.CommandType = CommandType.Text;

            comando3.CommandText = "exec sp_addrolemember 'DB_DATAREADER', '" + usuario + "';" + "exec sp_addrolemember 'DB_DATAWRITER', '" + usuario + "';";
            try
            {
                comando3.ExecuteNonQuery();
                transacao.Commit();
                return true;
            }
            catch (Exception ex)
            {
                transacao.Rollback();
                return false;
            }
            finally
            {
                bd.fecharConexao();
            }

        }

        public bool permissoes(string banco, string permissao, string tabela, string usuario)
        {
            Banco bd = new Banco();
            bd.Db = banco;
            SqlConnection cn = bd.abrirConexao();
            SqlTransaction transacao = cn.BeginTransaction();

            SqlCommand comando = new SqlCommand();

            comando.Connection = cn;
            comando.Transaction = transacao;
            comando.CommandType = CommandType.Text;

            comando.CommandText = "use " + banco + "; " + permissao + " select on " + tabela + " to " + usuario + ";";
            try
            {
                comando.ExecuteNonQuery();
                transacao.Commit();
                MessageBox.Show("Deu CERTO a permissao!");
                return true;
            }
            catch (Exception ex)
            {
                transacao.Rollback();
                MessageBox.Show("Deu ERRADO a permissao!");
                return false;
            }
            finally
            {
                bd.fecharConexao();
            }

        }

    }
}
