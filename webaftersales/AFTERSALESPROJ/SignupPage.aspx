<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignupPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.SignupPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/CSSsignup.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="signupform">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <table>
                        <tr>
                            <td colspan="3" style="align-content: center">
                                <h1>Sign Up</h1>
                            </td>
                        </tr>
                        <tr>
                            <td>Lastname</td>
                            <td>
                                <asp:TextBox CssClass="tboxinput" ID="lastnametbox" runat="server"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ValidationGroup="val1" ID="RequiredFieldValidator4" ControlToValidate="lastnametbox" runat="server"
                                    ErrorMessage="lastname is required" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>Firstname</td>
                            <td>
                                <asp:TextBox CssClass="tboxinput" ID="firstnametbox" runat="server"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ValidationGroup="val1" ID="RequiredFieldValidator5" ControlToValidate="firstnametbox" runat="server"
                                    ErrorMessage="firstname is required" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>User Name</td>
                            <td>
                                <asp:TextBox CssClass="tboxinput" ID="usernametbox" runat="server"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ValidationGroup="val1" ID="RequiredFieldValidator1" ControlToValidate="usernametbox" runat="server"
                                    ErrorMessage="username is required" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td>
                                <asp:TextBox CssClass="tboxinput" ID="passwordtbox" runat="server" TextMode="Password"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ValidationGroup="val1" ID="RequiredFieldValidator2" ControlToValidate="passwordtbox" runat="server"
                                    ErrorMessage="password is required" ForeColor="Red">*</asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td>Confirm Password</td>
                            <td>
                                <asp:TextBox CssClass="tboxinput" ID="confirmpasswordtbox" runat="server" TextMode="Password"></asp:TextBox></td>
                            <td>
                                <asp:RequiredFieldValidator ValidationGroup="val1" ID="RequiredFieldValidator3" ControlToValidate="confirmpasswordtbox" runat="server"
                                    ErrorMessage="please verify your password" ForeColor="Red">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ValidationGroup="val1" ID="CompareValidator1" ControlToValidate="confirmpasswordtbox" ControlToCompare="passwordtbox" runat="server"
                                    ErrorMessage="password did not match" ForeColor="Red">*</asp:CompareValidator></td>
                        </tr>

                        <tr>
                            <td colspan="3">
                                <br />

                                <asp:Button ID="signupbtn" CssClass="btn" runat="server" Text="Sign Up" ValidationGroup="val1" OnClick="signupbtn_Click" />
                                    <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <asp:ValidationSummary ID="val1" ValidationGroup="val1" runat="server" ForeColor="Red" />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3">Already have account?
                                <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" NavigateUrl="~/AFTERSALESPROJ/LoginPage.aspx">Sign in here</asp:HyperLink></td>
                        </tr>

                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
