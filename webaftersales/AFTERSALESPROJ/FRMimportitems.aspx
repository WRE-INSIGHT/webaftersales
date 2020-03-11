<%@ Page Title="" Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="FRMimportitems.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.FRMimportitems" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/gridcss.css" rel="stylesheet" />
    <script>
        function confimmessage() {
            confirm('import selected items?');
        }
        function redirectme()
        {
            window.open("frmReport.aspx");
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Label ID="Label1" runat="server" Text="KMDI System data" Font-Bold="False" Font-Names="Century Gothic" Font-Size="24pt" ForeColor="#000066"></asp:Label>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <br />
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" EmptyDataText="No result found." AllowPaging="True" CellPadding="4" Font-Names="Segoe UI" GridLines="None" DataKeyNames="ID" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound" ForeColor="#333333">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:CheckBox ID="cboxselect" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="ID" DataField="ID" />
                    <asp:BoundField HeaderText="K#" DataField="KMDI_NO" />
                    <asp:BoundField HeaderText="ITEM#" DataField="ITEM_NO" />
                    <asp:BoundField HeaderText="LOCATION" DataField="LOCATION" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <FooterStyle BackColor="#5D7B9D" ForeColor="White" Font-Bold="True" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
            </asp:GridView>
            <br />
            <br />
            <asp:Button ID="btnimport" CssClass="gridbtn" runat="server" OnClick="btnimport_Click" Text="import selected rows" />

        </ContentTemplate>
    </asp:UpdatePanel>
    <br />
    <br />
    <div>
        <asp:HyperLink ID="HyperLink1" NavigateUrl="~/AFTERSALESPROJ/frmReport.aspx" runat="server" Text="&lt;&lt; back to report"></asp:HyperLink>
    </div>
</asp:Content>
