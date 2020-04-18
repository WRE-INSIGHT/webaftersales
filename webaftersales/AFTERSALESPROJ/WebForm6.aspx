<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm6.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.WebForm6" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </div>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="getdata" />
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <asp:Button ID="Button2" runat="server" Text="removecache" OnClick="Button2_Click" />
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Button" />
    </form>
</body>
</html>
