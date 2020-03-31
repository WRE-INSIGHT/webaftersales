<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignupPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.SignupPage" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap.min.js"></script>
    <%--  <link href="css/CSSsignup.css" rel="stylesheet" />--%>
    <style>
        .tbl td{
            padding-bottom:10px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container-fluid">
            <div class="jumbotron">
                <h1>Kenneth and Mock <small>WINDOWS AND DOORS</small></h1>

            </div>
        </div>
        <div class="container">

            <div class="row">
                <div class="col-sm-6">
                    <h1>Sign Up</h1>
                    <p>
                        Already have account?
                <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" NavigateUrl="~/AFTERSALESPROJ/LoginPage.aspx">Sign in here</asp:HyperLink>
                    </p>
                    <blockquote>
                        <div class="form-group">
                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <table class="tbl">
                                        <tr>
                                            <td style="width: 100%">
                                                <asp:TextBox CssClass="form-control" Height="40" ID="lastnametbox" placeholder="Lastname" runat="server"></asp:TextBox></td>
                                            <td>
                                                <asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator4" ControlToValidate="lastnametbox" runat="server"
                                                    ErrorMessage="lastname is required">*</asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox CssClass="form-control" Height="40" placeholder="Firstname" ID="firstnametbox" runat="server" OnTextChanged="firstnametbox_TextChanged"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator5" ControlToValidate="firstnametbox" runat="server"
                                                    ErrorMessage="firstname is required">*</asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox CssClass="form-control" Height="40" placeholder="Username" ID="usernametbox" runat="server"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator1" ControlToValidate="usernametbox" runat="server"
                                                    ErrorMessage="username is required">*</asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox CssClass="form-control" Height="40" placeholder="Password" ID="passwordtbox" runat="server" TextMode="Password"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator2" ControlToValidate="passwordtbox" runat="server"
                                                    ErrorMessage="password is required">*</asp:RequiredFieldValidator></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:TextBox CssClass="form-control" Height="40" placeholder="Confirm password" ID="confirmpasswordtbox" runat="server" TextMode="Password"></asp:TextBox></td>
                                            <td>
                                                <asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator3" ControlToValidate="confirmpasswordtbox" runat="server"
                                                    ErrorMessage="please verify your password">*</asp:RequiredFieldValidator>
                                                <asp:CompareValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="CompareValidator1" ControlToValidate="confirmpasswordtbox" ControlToCompare="passwordtbox" runat="server"
                                                    ErrorMessage="password did not match">*</asp:CompareValidator></td>
                                        </tr>
                                    </table>

                                    <asp:Button ID="signupbtn" CssClass="btn btn-primary" runat="server" Text="Sign Up" ValidationGroup="val1" OnClick="signupbtn_Click" />
                                    <br />
                                    <br />

                                    <asp:ValidationSummary ID="val1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />


                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </blockquote>
                </div>
                <div class="col-sm-6">


                    <h1>About Us</h1>
                    <p>BRIEF HISTORY</p>
                    <blockquote>
                        <p>
                            Kenneth and Mock Designs, Inc. (Kenneth&Mock™) started December 1997. It came in with the vision of introducing and providing top quality European products and technology to our construction industry in the window and door segment.
                        </p>
                        <p>
                            Being the first of its kind to enter the Philippine market, Kenneth&Mock™ provided the much needed alternative to steel, aluminum or even wooden windows and doors specially in terms of quality. It made such an impact in the industry that it cornered the high-end residential market, taking up a major share of the once used-to-be aluminum dominated market. Kenneth&Mock™ raised the bar and set the standard in quality windows and doors.
                        </p>
                        <p>
                            Kenneth&Mock™ with over 4,000 clients nationwide is known for 20 years of service excellence.
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
