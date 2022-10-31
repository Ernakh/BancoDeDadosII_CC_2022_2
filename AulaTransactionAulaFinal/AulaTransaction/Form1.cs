using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AulaTransaction
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Pessoa p = new Pessoa();
            p.nome = textBox1.Text;
            p.idade = int.Parse(textBox2.Text);
            p.altura = int.Parse(textBox3.Text);
            
            if(p.gravar())
            {
                MessageBox.Show("Gravado com sucesso!");
                button2_Click(null, null);
            }
            else
            {
                MessageBox.Show("Erro ao gravar.");
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Banco bd = new Banco();
            DataTable dt = new DataTable();

            dt = bd.executaConsulta("select * from pessoas");

            dataGridView1.DataSource = dt;
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Banco bd = new Banco();
            DataTable dt = new DataTable();

            dt = bd.executaConsulta("select * from pessoas " +
                "where nome = '" + textBox4.Text + "'");

            dataGridView1.DataSource = dt;
        }
    }
}
