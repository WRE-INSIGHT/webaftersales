<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmknogen.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.frmknogen" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" EmptyDataText="No result found." DataKeyNames="ID" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="cb"></asp:CheckBox>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="ID" Visible="false" DataField="ID" />
                    <asp:BoundField HeaderText="K#" DataField="KMDI_NO" />
                    <asp:BoundField HeaderText="ITEM#" DataField="ITEM_NO" />
                    <asp:BoundField HeaderText="LOCATION" DataField="LOCATION" />
                </Columns>
            </asp:GridView>

            <br />
            <asp:Button ID="btnaddtoreport" runat="server" OnClick="btnaddtoreport_Click" Text="add to report" />

        </div>
    </form>
</body>
</html>
