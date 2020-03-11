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
            <div class="innerform" >
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
                            <asp:TextBox ID="passwordtbox" CssClass="tboxinput" runat="server"></asp:TextBox></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan=" 2">
                            <asp:Button ID="loginbtn" CssClass="btn" runat="server" Text="Login" /></td>
                    </tr>
                    <tr>
                        <td colspan=" 3">
                            <asp:Label ID="errorlbl" runat="server"></asp:Label></td>
                    </tr>
                </table>
            </div>
        </div>


    </form>

</body>
</html>
