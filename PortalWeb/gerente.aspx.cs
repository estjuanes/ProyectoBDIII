using System;
using System.Data;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Login_InfoToolsSV
{
    public partial class IndexNewPage : System.Web.UI.Page
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

        protected void BtnEjecutarConsultaPredefinida_Click(object sender, EventArgs e)
        {
            string consultaSeleccionada = ddlConsultasPredefinidas.SelectedValue;
            string query = "";

            switch (consultaSeleccionada)
            {
                case "1":
                    query = "SELECT Region, SUM(Ventas) AS TotalVentas FROM Ventas GROUP BY Region";
                    break;
                case "2":
                    query = "SELECT Año, SUM(Ingresos) AS TotalIngresos FROM Ventas GROUP BY Año";
                    break;
                case "3":
                    query = "SELECT Producto, SUM(CantidadVendida) AS TotalVentas FROM Ventas GROUP BY Producto";
                    break;
                default:
                    ltResultadoConsulta.Text = "Por favor, selecciona una consulta.";
                    return;
            }

            ltResultadoConsulta.Text = "Consulta ejecutada: " + query;
        }

        protected void BtnDescargarInforme_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Región");
            dt.Columns.Add("Ventas");

            dt.Rows.Add("Región 1", "120");
            dt.Rows.Add("Región 2", "150");
            dt.Rows.Add("Región 3", "180");

            string csv = ConvertDataTableToCSV(dt);
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=Informe.csv");
            Response.Charset = "";
            Response.ContentType = "application/text";
            Response.Output.Write(csv);
            Response.Flush();
            Response.End();
        }

        private string ConvertDataTableToCSV(DataTable dt)
        {
            StringWriter sw = new StringWriter();

            for (int i = 0; i < dt.Columns.Count; i++)
            {
                sw.Write(dt.Columns[i]);
                if (i < dt.Columns.Count - 1)
                {
                    sw.Write(",");
                }
            }
            sw.Write(sw.NewLine);

            foreach (DataRow dr in dt.Rows)
            {
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    sw.Write(dr[i].ToString());
                    if (i < dt.Columns.Count - 1)
                    {
                        sw.Write(",");
                    }
                }
                sw.Write(sw.NewLine);
            }

            return sw.ToString();
        }
    }
}


