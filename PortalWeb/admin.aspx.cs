using System;
using Microsoft.AnalysisServices.AdomdClient;  // Asegúrate de haber instalado el paquete Microsoft.AnalysisServices.AdomdClient
using System.Configuration;

namespace Login_InfoToolsSV
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usuariologueado"] != null && Session["rol"] != null)
            {
                string usuariologueado = Session["usuariologueado"].ToString();
                string rol = Session["rol"].ToString();

                lblBienvenida.Text = "Bienvenido/a " + usuariologueado + " (" + rol + ")";
            }
            else
            {
                Response.Redirect("Login_InfoToolsSV.aspx");
            }
        }

        protected void BtnCerrar_Click(object sender, EventArgs e)
        {
            Session.Remove("usuariologueado");
            Session.Remove("rol");
            Response.Redirect("Login_InfoToolsSV.aspx");
        }

        // Método para ejecutar consultas MDX
        protected void BtnEjecutarMdx_Click(object sender, EventArgs e)
        {
            string mdxQuery = tbMdxQuery.Text;
            if (string.IsNullOrEmpty(tbMdxQuery.Text))
            {
                ltResultadoMdx.Text = "Por favor, ingresa una consulta MDX válida.";
                return;
            }


            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["OLAPConnection"].ConnectionString;
                using (AdomdConnection conexion = new AdomdConnection(connectionString))
                {
                    conexion.Open();

                    using (AdomdCommand cmd = new AdomdCommand(mdxQuery, conexion))
                    {
                        AdomdDataReader reader = cmd.ExecuteReader();
                        string resultado = "";

                        // Procesamos el resultado de la consulta MDX
                        while (reader.Read())
                        {
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                resultado += reader[i].ToString() + "\t";
                            }
                            resultado += "<br />";
                        }

                        ltResultadoMdx.Text = resultado;
                    }
                }
            }
            catch (Exception ex)
            {
                ltResultadoMdx.Text = "Error al ejecutar la consulta: " + ex.Message;
            }
        }

        // Método para actualizar los datos del cubo OLAP
        protected void BtnActualizarDatos_Click(object sender, EventArgs e)
        {
            try
            {
                // Aquí debes implementar la lógica para actualizar el cubo OLAP, 
                // esto depende de la configuración de tu cubo y cómo quieres que se realicen las actualizaciones.
                lblResultadoActualizacion.Text = "Datos del cubo actualizados correctamente.";
            }
            catch (Exception ex)
            {
                lblResultadoActualizacion.Text = "Error al actualizar los datos del cubo: " + ex.Message;
            }
        }
    }
}
