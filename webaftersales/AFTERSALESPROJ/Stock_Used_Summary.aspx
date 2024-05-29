<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="Stock_Used_Summary.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.Stock_Used_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Stock Used Summary</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h2>Stock Used Summary</h2>
        </div>
        <div class="well">
            <div class="row">
                <div class="col-sm-6"></div>
                <div class="col-sm-6">
                    <span>Stock Used</span>
                    <div class="input-group">
                        <asp:DropDownList ID="ddlStockUsed" CssClass="form-control" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Mesh with tube</asp:ListItem>
                            <asp:ListItem>Plisse Cord</asp:ListItem>
                            <asp:ListItem>Zigzag/Magnum Cord</asp:ListItem>
                            <asp:ListItem>Caterpillar</asp:ListItem>
                        </asp:DropDownList>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click">Search</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div style="overflow-x: auto">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" Width="100%" CellPadding="3" AllowPaging="True" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" OnPageIndexChanging="gv_PageIndexChanging" PageSize="15">
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                        <Columns>
                            <asp:TemplateField HeaderText="PROJECT">
                                <ItemTemplate>
                                    <div style="min-width: 300px;">
                                        <span style="font-size: small"><%# Eval("PROJECT").ToString() %></span><br />
                                        <span style="font-size: x-small"><%# Eval("ADDRESS").ToString() %></span><br />
                                        <span style="font-size: x-small" class="text-info"><%# Eval("JO").ToString() %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="ITEM_DESCRIPTION">
                                <ItemTemplate>
                                    <div style="min-width: 250px">
                                        <span style="font-size: small"><%# Eval("LOCATION").ToString() %></span><br />
                                        <span style="font-size: smaller"><%# Eval("KNO").ToString() %></span> / 
                            <span style="font-size: smaller"><%# Eval("ITEMNO").ToString() %></span><br />
                                        <span style="font-size: smaller"><%# Eval("ITEM_DESCRIPTION").ToString() %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="STOCK USED">
                                <ItemTemplate>
                                    <div style="min-width: 200px;">
                                        <span style="font-size: small"><%# Eval("STOCK_USED").ToString() %></span><br />
                                        <span style="font-size: smaller"><%# Eval("MEASUREMENT").ToString() %></span><br />
                                        <span style="font-size: smaller"><%# Eval("QUANTITY").ToString() %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="DATE">
                                <ItemTemplate>
                                    <div style="min-width: 100px;">
                                        <span style="font-size: small"><%# Eval("SDATE").ToString() %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="UPDATE LOG">
                                <ItemTemplate>
                                    <div style="white-space: nowrap">
                                        <span style="font-size: small"><%# Server.HtmlDecode(Regex.Replace(Eval("DATE_MODIFIED").ToString(), "\r\n|\r|\n", "<br>")) %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" ForeColor="Black" BackColor="White" />
                        <EmptyDataTemplate>
                            <div class="">
                                <h2><strong>This Table is empty</strong></h2>
                            </div>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
