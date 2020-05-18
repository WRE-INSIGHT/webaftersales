<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="dhplogin.aspx.cs" Inherits="webaftersales.DAILYHEALTHPROFILE.dhplogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <link href="css/gridcss.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="jumbotron">
            <h1><strong>Kenneth and Mock</strong> <small>WINDOWS AND DOORS</small></h1>
        </div>
        <h1 class="text-center">Daily Health Profile </h1>
        <div class="container">
            <div class="well">
                <h1>Sign in</h1>
                <br />
                Employee No<br />
                <asp:TextBox ID="tboxempno" CssClass="form-control" runat="server"></asp:TextBox>
                <br />
                Password<br />
                <asp:TextBox ID="tboxpassword" CssClass="form-control" TextMode="Password" runat="server" OnTextChanged="tboxpassword_TextChanged"></asp:TextBox><br />
                <div class="checkbox">
                    <asp:CheckBox ID="CheckBox1" runat="server" Text="Remember me" Checked="True" />
                </div>
                <asp:Button ID="Button1" runat="server" CssClass="btn btn-primary" Text="Login" OnClick="Button1_Click" />
                <asp:ValidationSummary CssClass="alert alert-danger" ValidationGroup="val1" ID="ValidationSummary1" runat="server" />
            </div>
        </div>
    </form>
</body>
</html>
