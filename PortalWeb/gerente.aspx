<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gerente.aspx.cs" Inherits="Login_InfoToolsSV.IndexNewPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" />
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <!-- Custom CSS -->
    <link href="Recursos/CSS/Estilos.css" rel="stylesheet" />
    
    <title>Portal del Gerente</title>
    
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container-form {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.1);
            margin-top: 50px;
        }
        .form-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #343a40;
        }
        .custom-btn {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            margin-top: 20px;
        }
        .result-box {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 5px;
            margin-top: 15px;
        }
        .chart-container {
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="container-form">
        <form id="formulario_gerente" runat="server">
            <!-- Mensaje de bienvenida -->
            <div class="text-center">
                <asp:Label ID="lblBienvenida" runat="server" Text="Bienvenido/a" CssClass="form-title"></asp:Label>
            </div>

            <!-- Botón para cerrar sesión -->
            <div class="text-center">
                <asp:Button ID="BtnCerrar" runat="server" Text="Cerrar Sesión" CssClass="btn btn-dark custom-btn" OnClick="BtnCerrar_Click" />
            </div>

            <!-- Sección para consultas predefinidas -->
            <div class="mdx-container">
                <h4>Consultas predefinidas</h4>
                <asp:DropDownList ID="ddlConsultasPredefinidas" runat="server" CssClass="form-select">
                    <asp:ListItem Value="0">Seleccione una consulta...</asp:ListItem>
                    <asp:ListItem Value="1">Ventas por región</asp:ListItem>
                    <asp:ListItem Value="2">Ingresos anuales</asp:ListItem>
                    <asp:ListItem Value="3">Productos más vendidos</asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="BtnEjecutarConsultaPredefinida" runat="server" Text="Ejecutar Consulta" CssClass="btn btn-primary custom-btn" OnClick="BtnEjecutarConsultaPredefinida_Click" />

                <!-- Resultado de la consulta -->
                <div class="result-box">
                    <asp:Label ID="lblResultadoConsulta" runat="server" Text="Resultado de la consulta:" CssClass="form-label"></asp:Label>
                    <asp:Literal ID="ltResultadoConsulta" runat="server"></asp:Literal>
                </div>
            </div>

            <!-- Sección para visualización de reportes gráficos -->
            <div class="chart-container">
                <h4>Reporte gráfico</h4>
                <canvas id="chartReport" width="400" height="200"></canvas>
            </div>

            <!-- Sección para descargar informes -->
            <div class="mdx-container">
                <asp:Button ID="BtnDescargarInforme" runat="server" Text="Descargar Informe CSV" CssClass="btn btn-success custom-btn" OnClick="BtnDescargarInforme_Click" />
            </div>
        </form>
    </div>

    <script>
        // Ejemplo de gráfico (usando Chart.js)
        var ctx = document.getElementById('chartReport').getContext('2d');
        var chartReport = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Región 1', 'Región 2', 'Región 3'],
                datasets: [{
                    label: 'Ventas',
                    data: [120, 150, 180],
                    backgroundColor: ['#007bff', '#28a745', '#dc3545'],
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>



