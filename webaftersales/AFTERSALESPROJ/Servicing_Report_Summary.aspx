<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Servicing_Report_Summary.aspx.cs" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" Inherits="webaftersales.AFTERSALESPROJ.Servicing_Report_Summary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Assessment Summary Report</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="container">
        <div class="well">
            <h3><strong>Assessment Summary Report</strong></h3>
        </div>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div class="well">
                    <div class="row">
                        <div class="col-sm-8"></div>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <asp:TextBox runat="server" ID="tboxSearch" CssClass="form-control"></asp:TextBox>
                                <div class="input-group-btn">
                                    <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" Text="Search" OnClick="btnSearch_Click"></asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <div>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" PageSize="25" OnRowCommand="GridView1_RowCommand" AutoGenerateColumns="false"
                        CssClass="table" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" GridLines="Horizontal" ForeColor="Black" OnPageIndexChanging="GridView1_PageIndexChanging">
                        <Columns>

                            <asp:TemplateField HeaderText="CIN">
                                <ItemTemplate>
                                    <div style="white-space: nowrap">
                                        <span><%# Eval("cin") %></span><br />
                                        <span><%# Eval("cdate") %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Project">
                                <ItemTemplate>
                                    <div style="min-width: 300px;">
                                        <span><%# Eval("project_label") %></span><br />
                                        <span style="font-size: smaller;"><%# Eval("FULLADD") %></span><br />
                                        <span style="font-size: small;"><%# Eval("SUB_JO") %></span>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblCIN" runat="server" Visible="false" Text='<%# Bind("CIN") %>'></asp:Label>
                                        <asp:LinkButton runat="server" ID="btnViewReport" Text="view all report" CommandName="viewReport"></asp:LinkButton>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />

                        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                        <SortedDescendingHeaderStyle BackColor="#242121" />
                        <PagerSettings PageButtonCount="10" Position="TopAndBottom" />
                        <PagerStyle CssClass="GridPager" BackColor="White" ForeColor="Black" HorizontalAlign="Left" />
                        <EmptyDataTemplate>
                            <p style="font-size: x-large" class="text-danger">Empty Table</p>
                        </EmptyDataTemplate>
                    </asp:GridView>
                    <asp:Label ID="lblRowNum" runat="server" Font-Size="Large" Text="Results"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
</asp:Content>
