<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.LoginPage" %>

<meta name="viewport" content="width=device-width, initial-scale=1">
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
        <div class="container-fluid">
            <div class="jumbotron">
                <h1><strong>Kenneth and Mock</strong> <small>WINDOWS AND DOORS</small></h1>

            </div>
        </div>
        <div class="container">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/DAILYHEALTHPROFILE/dhplogin.aspx" runat="server">Daily Health Profile</asp:LinkButton><br />
            <div class="row">
                <div class="col-sm-4">
                    <div class="container">
                        <h1>Sign in</h1>
                        <p>
                            Not registered yet?
                            <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" NavigateUrl="~/AFTERSALESPROJ/SignupPage.aspx">Sign Up here</asp:HyperLink>
                        </p>
                        <blockquote>
                            <div class="form-group">
                                <div class="form-group">
                                    <label class="sr-only" for="email">Username:</label>
                                    <asp:TextBox ID="usernametbox" Height="40" CssClass="form-control" placeholder="Username" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label class="sr-only" for="pwd">Password:</label>
                                    <asp:TextBox ID="passwordtbox" Height="40" CssClass="form-control" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                                </div>
                                <div class="checkbox">

                                    <asp:CheckBox ID="CheckBox1" runat="server" Text="Remember me" Checked="True" />

                                </div>

                                <asp:Button ID="loginbtn" Width="143px" class="btn btn-primary" runat="server" Text="Login" OnClick="loginbtn_Click" />
                            </div>
                            <asp:ValidationSummary CssClass="alert alert-danger" ValidationGroup="val1" ID="ValidationSummary1" runat="server" />
                        </blockquote>
                    </div>
                </div>
                <div class="col-sm-4">
                    <h1>Our Mission</h1>
                    <p>Kenneth&Mock™ is</p>
                    <blockquote>
                        <p>
                            committed to do business with integrity by providing all our clientele with excellent quality products and exceptional service.
                        </p>
                        <footer>
                            <p><a class="btn btn-default" href="https://www.kennethandmock.com/">Learn more &raquo;</a></p>
                        </footer>
                    </blockquote>
                </div>
                <div class="col-sm-4">
                    <h1>Our Vision</h1>
                    <p>Kenneth&Mock™ is</p>
                    <blockquote>
                        <p>
                            at the forefront of the newest and most suitable window and door product and accessories in the Philippine market.
                        </p>
                        <footer>
                            <p><a class="btn btn-default" href="https://www.kennethandmock.com/">Learn more &raquo;</a></p>
                        </footer>
                    </blockquote>
                </div>
            </div>
        </div>
        <footer class="container-fluid text-center">
                <br />
                <br />
                <br />
                <p>Copyright 2020. Kenneth and Mock windows and doors. All rights Reserved.</p>
        </footer>

    </form>

</body>
</html>
