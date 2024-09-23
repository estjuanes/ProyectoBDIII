<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin.aspx.cs" Inherits="Login_InfoToolsSV.Index" %>

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
    
    <!-- Custom CSS -->
    <link href="Recursos/CSS/Estilos.css" rel="stylesheet" />
    
    <title>Portal del Administrador</title>
    
    <style>
        body {
            background-color: #f8f9fa; /* Fondo claro */
        }
        .container-form {
            max-width: 600px;
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
            color: #343a40; /* Texto oscuro */
        }
        .custom-btn {
            width: 100%;
            padding: 10px;
            font-size: 16px;
            margin-top: 20px;
        }
        .mdx-container {
            margin-top: 30px;
        }
        .mdx-query-box {
            height: 150px;
            margin-bottom: 20px;
        }
        .result-box {
            background-color: #e9ecef;
            padding: 15px;
            border-radius: 5px;
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <div class="container-form">
        <form id="formulario_index" runat="server">
            <!-- Mensaje de bienvenida -->
            <div class="text-center">
                <asp:Label ID="lblBienvenida" runat="server" Text="Bienvenido/a" CssClass="form-title"></asp:Label>
            </div>

            <!-- Botón para cerrar sesión -->
            <div class="text-center">
                <asp:Button ID="BtnCerrar" runat="server" Text="Cerrar Sesión" CssClass="btn btn-dark custom-btn" OnClick="BtnCerrar_Click" />
            </div>

            <!-- Sección para consultas MDX -->
            <div class="mdx-container">
                <h4>Ejecutar consulta MDX</h4>
                <asp:TextBox ID="tbMdxQuery" runat="server" TextMode="MultiLine" CssClass="form-control mdx-query-box" placeholder="Ingrese su consulta MDX aquí"></asp:TextBox>
                <asp:Button ID="BtnEjecutarMdx" runat="server" Text="Ejecutar MDX" CssClass="btn btn-primary custom-btn" OnClick="BtnEjecutarMdx_Click" />

                <!-- Resultado de la consulta -->
                <div class="result-box">
                    <asp:Label ID="lblResultadoMdx" runat="server" Text="Resultado de la consulta:" CssClass="form-label"></asp:Label>
                    <asp:Literal ID="ltResultadoMdx" runat="server"></asp:Literal>
                </div>
            </div>

            <!-- Sección para modificar datos del cubo OLAP -->
            <div class="mdx-container">
                <h4>Modificar datos del cubo OLAP</h4>
                <asp:Button ID="BtnActualizarDatos" runat="server" Text="Actualizar Datos del Cubo" CssClass="btn btn-success custom-btn" OnClick="BtnActualizarDatos_Click" />

                <!-- Resultado de la actualización -->
                <div class="result-box">
                    <asp:Label ID="lblResultadoActualizacion" runat="server" Text="Resultado de la actualización:" CssClass="form-label"></asp:Label>
                </div>
            </div>
        </form>
    </div>
</body>
</html>