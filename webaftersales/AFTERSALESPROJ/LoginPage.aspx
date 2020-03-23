<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign in</title>
    <%--   <link href="css/CSSloginPage.css" rel="stylesheet" />--%>
    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap.min.js"></script>
</head>
<body class="body">
    <form id="fomr1" runat="server">
        <div class="container">
           
            <div class="well-lg">
                <div class="page-header">
                <h1>Sign in</h1>
            </div>
         
            <div class="form-group">
                <div class="form-group">
                    <label class="sr-only" for="email">Email:</label>
                    <asp:TextBox ID="usernametbox"  Height="50" CssClass="form-control" placeholder="Username" runat="server"></asp:TextBox>
                </div>
                <div class="form-group">
                    <label class="sr-only" for="pwd">Password:</label>
                    <asp:TextBox ID="passwordtbox" Height="50" CssClass="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                </div>
                <div class="checkbox">
                    <label>
                        <input type="checkbox" name="remember">
                        Remember me</label>
                </div>

                <asp:Button ID="loginbtn" Width="143px" class="btn btn-default" runat="server" Text="Login" OnClick="loginbtn_Click" />
            </div>
                <asp:ValidationSummary CssClass="alert alert-danger" ValidationGroup="val1" ID="ValidationSummary1" runat="server" />   
                <div>
                      <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" NavigateUrl="~/AFTERSALESPROJ/SignupPage.aspx">Sign Up here</asp:HyperLink>
                </div>
            
           </div>
           </div>

    </form>

</body>
</html>
