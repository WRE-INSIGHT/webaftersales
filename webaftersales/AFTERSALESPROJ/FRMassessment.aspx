<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FRMassessment.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.FRMassessment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/CSSassessment.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="tab">
            <asp:button runat="server"  CssClass="tabbtn" Text="Profile / Reinforcement"></asp:button>
            <asp:button runat="server" CssClass="tabbtn" Text="Hardware"></asp:button>
            <asp:button runat="server" CssClass="tabbtn" Text="Accessories"></asp:button>
            <asp:button runat="server" CssClass="tabbtn" Text="Rollup"></asp:button>
        </div>
    </form>
</body>
</html>
