using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace Login_InfoToolsSV
{
    public partial class Login_InfoToolsSV : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        string patron = "InfoToolsSV";
        protected void BtnIngresar_Click(object sender, EventArgs e)
        {
            string conectar = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;
            SqlConnection sqlConectar = new SqlConnection(conectar);
            SqlCommand cmd = new SqlCommand("SP_ValidarUsuario", sqlConectar)
            {
                CommandType = CommandType.StoredProcedure
            };

            cmd.Connection.Open();
            cmd.Parameters.Add("@Usuario", SqlDbType.VarChar, 50).Value = tbUsuario.Text;
            cmd.Parameters.Add("@Contrasenia", SqlDbType.VarChar, 50).Value = tbPassword.Text;
            cmd.Parameters.Add("@Patron", SqlDbType.VarChar, 50).Value = patron;
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                // Obtenemos el rol del usuario desde la base de datos
                string rol = dr["Rol"].ToString();

                // Guardamos el rol y el usuario en sesión
                Session["usuariologueado"] = tbUsuario.Text;
                Session["rol"] = rol;

                // Redirigimos a la página de inicio según el rol del usuario
                if (rol == "admin")
                {
                    //Agregamos una sesion de usuario
                    Session["usuariologueado"] = tbUsuario.Text;
                    Response.Redirect("admin.aspx");
                }
                else if (rol == "gerente")
                {
                    Response.Redirect("gerente.aspx");
                }
                else if (rol == "analista")
                {
                    Response.Redirect("analista.aspx");
                }
                else
                {
                    lblError.Text = "Rol no autorizado.";
                }
            }
            else
            {
                lblError.Text = "Error de Usuario o Contraseña";
            }

            cmd.Connection.Close();
        }
    }
}
