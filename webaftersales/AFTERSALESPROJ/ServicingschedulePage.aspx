<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ServicingschedulePage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.ServicingschedulePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            <asp:Panel ID="Panel1" runat="server" DefaultButton="searcbtn">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div>
                            <asp:TextBox ID="searchtbox" placeholder="search project" runat="server"></asp:TextBox>
                            <asp:Button ID="searcbtn" Width="0px" runat="server" Text="" OnClick="searcbtn_Click" />
                        </div>
                        <asp:GridView ID="GridView1" GridLines="None" runat="server" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" ShowHeader="False" HorizontalAlign="Left">
                            <Columns>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <asp:Label ID="idlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                        <asp:Label ID="jolbl" Visible="false" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                        <asp:Label ID="teamlbl" Visible="false" runat="server" Text='<%# Bind("TEAMID") %>'></asp:Label>
                                        <asp:LinkButton ID="projectlbl" CommandName="report" runat="server" Text='<%# Bind("PROJECT") %>'></asp:LinkButton>
                                        <br />
                                        <asp:Label ID="datelbl" Font-Size="20px" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="addresslbl" Font-Size="15px" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>

                                    </ItemTemplate>
                                </asp:TemplateField>
              
                            </Columns>
                            <EditRowStyle BorderStyle="None" BorderWidth="0px" />
                            <RowStyle Font-Names="Calibri" Font-Size="18pt" Height="120px" CssClass="rowstyle" />
                        </asp:GridView>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
        </div>
    </form>
</body>
</html>
