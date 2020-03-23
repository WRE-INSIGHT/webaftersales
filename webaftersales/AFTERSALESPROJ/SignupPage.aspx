<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignupPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.SignupPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up</title>
    <script src="../Scripts/bootstrap.js"></script>
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <link href="../Content/bootstrap.min.css" rel="stylesheet" />
    <script src="../Scripts/bootstrap.min.js"></script>
    <%--  <link href="css/CSSsignup.css" rel="stylesheet" />--%>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
         
                <div class="page-header">
                    <h1>Sign Up</h1>
                </div>
         
            <div class="form-group">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="form-group">
                            <asp:TextBox CssClass="form-control" Height="50" ID="lastnametbox" placeholder="Lastname" runat="server"></asp:TextBox><asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator4" ControlToValidate="lastnametbox" runat="server"
                                ErrorMessage="lastname is required" >*</asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:TextBox CssClass="form-control" Height="50" placeholder="Firstname" ID="firstnametbox" runat="server" OnTextChanged="firstnametbox_TextChanged"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator5" ControlToValidate="firstnametbox" runat="server"
                                ErrorMessage="firstname is required" >*</asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:TextBox CssClass="form-control" Height="50" placeholder="Username" ID="usernametbox" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator1" ControlToValidate="usernametbox" runat="server"
                                ErrorMessage="username is required" >*</asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:TextBox CssClass="form-control" Height="50" placeholder="Password" ID="passwordtbox" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator2" ControlToValidate="passwordtbox" runat="server"
                                ErrorMessage="password is required" >*</asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <asp:TextBox CssClass="form-control" Height="50" placeholder="Confirm password" ID="confirmpasswordtbox" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="RequiredFieldValidator3" ControlToValidate="confirmpasswordtbox" runat="server"
                                ErrorMessage="please verify your password" >*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ValidationGroup="val1" CssClass="alert alert-danger" ID="CompareValidator1" ControlToValidate="confirmpasswordtbox" ControlToCompare="passwordtbox" runat="server"
                                ErrorMessage="password did not match" >*</asp:CompareValidator>
                        </div>


                        <asp:Button ID="signupbtn" CssClass="btn btn-default" runat="server" Text="Sign Up" ValidationGroup="val1" OnClick="signupbtn_Click" />
                        <br />
                        <br />

                        <asp:ValidationSummary ID="val1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
                        Already have account?
                                <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" NavigateUrl="~/AFTERSALESPROJ/LoginPage.aspx">Sign in here</asp:HyperLink>

                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </form>
</body>
</html>
