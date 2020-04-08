<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="ServicingschedulePage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.ServicingschedulePage" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</asp:Content>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="page-header">
        <h1><strong>Servicing Records</strong><small>as per call-in control#</small></h1>
    </div>
    <div class="container">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

        <asp:GridView ID="GridView1" runat="server" PageSize="8" GridLines="None" AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div class='<%# Eval("STATUS").ToString() == "Done" ? "panel panel-primary" : "panel panel-default" %>'>
                            <div class="panel-heading">
                              <strong>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("CIN")  %>'></asp:Label></strong> 

                            </div>
                            <div class="panel-body">
                                <table class="table" border="0">
                                    <tr>
                                        <td>
                                            <h4><strong>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("PROJECT")  %>'></asp:Label></strong></h4>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <small>
                                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("FULLADD")  %>'></asp:Label></small>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <asp:GridView ID="GridView2" ShowHeader="False" runat="server" DataSource='<%# Bind("schedule") %>' AutoGenerateColumns="False" BackColor="White" BorderColor="#336666" BorderStyle="Double" BorderWidth="3px" CellPadding="4" GridLines="Horizontal">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="" DataField="STATUS" />
                                                            <asp:BoundField HeaderText="" DataField="SERVICING" />
                                                            <asp:BoundField HeaderText="" DataField="SDATE" />
                                                        </Columns>
                                                        <FooterStyle BackColor="White" ForeColor="#333333" />
                                                        <HeaderStyle BackColor="#336666" Font-Bold="True" ForeColor="White" />
                                                        <PagerStyle BackColor="#336666" ForeColor="White" HorizontalAlign="Center" />
                                                        <RowStyle BackColor="White" ForeColor="#333333" />
                                                        <SelectedRowStyle BackColor="#339966" Font-Bold="True" ForeColor="White" />
                                                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                                        <SortedAscendingHeaderStyle BackColor="#487575" />
                                                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                                        <SortedDescendingHeaderStyle BackColor="#275353" />
                                                    </asp:GridView>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="panel-footer">
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("CDATE") %>'></asp:Label>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            
            <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
        </asp:GridView>
    </div>
</asp:Content>
