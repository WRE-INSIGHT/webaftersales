<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.LoginPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
   <link href="css/CSSloginPage.css" rel="stylesheet" />
</head>
<body class="body">
    <form id="fomr1" runat="server">
        <div class="form-style-8">
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />

            <table>
                <tr>
                    <td colspan="3">
                        <h1>Sign in</h1>
                    </td>
                </tr>
                <tr>
                    <td>User Name</td>
                    <td style="width: 300px">
                        <asp:TextBox ID="usernametbox" CssClass="tboxinput" runat="server"></asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td>
                        <asp:TextBox ID="passwordtbox" CssClass="tboxinput" runat="server" TextMode="Password"></asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan=" 2" style="margin: 20px">
                         <br />
                        <br />
                        <br />
                        <asp:Button ID="loginbtn" Width="143px" CssClass="btn" runat="server" Text="Login" OnClick="loginbtn_Click" />    
                    </td>
                </tr>
                <tr>
                    <td colspan=" 3">
                        <br />
                        <br />
                        <br />
                        <asp:Label ID="errorlbl" runat="server" ForeColor="Red"></asp:Label></td>
                </tr>
                <tr>
                    <td colspan="3">Dont have account yet?
                        <asp:HyperLink ID="HyperLink1" runat="server" ForeColor="Blue" NavigateUrl="~/AFTERSALESPROJ/SignupPage.aspx">Sign Up here</asp:HyperLink></td>
                </tr>
            </table>

        </div>


    </form>

</body>
</html>
