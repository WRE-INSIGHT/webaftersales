<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="quotationsummary.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationsummary" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation Payment Status</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Quotation Payment Status</strong></h3>
        <div class="input-group">
            <asp:TextBox ID="searchkey" runat="server" CssClass="form-control"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
                <asp:GridView ID="GridView1" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="panel panel-info">
                                    <div class="panel-heading">
                                        <asp:Label ID="lbljo" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                    </div>
                                    <div class="panel-body">
                                        <asp:Label ID="Label2" runat="server" Font-Size="X-Large" Text='<%# Bind("PROJECT") %>'></asp:Label><br />
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("FULLADD") %>'></asp:Label>
                                    </div>

                                    <asp:LinkButton ID="LinkButton2" runat="server" CommandName="showquotation" CssClass="btn btn-default"><span class="glyphicon glyphicon-resize-vertical"></span> quotation(s)</asp:LinkButton>
                                    <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
                                        <asp:GridView ID="GridView2" Visible="false" AutoGenerateColumns="false" CssClass="table table-striped" GridLines="None" runat="server">
                                            <Columns>
                                                <asp:TemplateField HeaderText="ASE #">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcin" runat="server" Visible="false" Text='<%# Bind("cin") %>'></asp:Label>
                                                        <asp:Label ID="lblsid" runat="server" Visible="false" Text='<%# Bind("sid") %>'></asp:Label>
                                                        <asp:Label ID="lblaseno" runat="server" Text='<%# Bind("aseno") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="SERVICE DONE">
                                                    <ItemTemplate>
                                                           <asp:Label ID="lblstatus" runat="server" Text='<%# Eval("STATUS").ToString() == "Done" ? "Yes" : "Not yet" %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DATE">
                                                    <ItemTemplate>
                                                        <asp:Label ID="datelbl" runat="server" Text='<%# Bind("qDATE") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="NET PRICE" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("netprice") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ACTUAL PRICE" ItemStyle-HorizontalAlign="Right">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("actualprice") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label7" runat="server" Visible='<%# Eval("foc").ToString()=="" ? false : true %>' Text='<%# Bind("foc") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                      <strong><asp:Label ID="Label8" runat="server" CssClass="text-success" Visible='<%# Eval("status").ToString()=="Done" ? true : false %>' Text='<%# Eval("status").ToString() + " Servicing" %>'></asp:Label></strong>  
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>

                                            <HeaderStyle Wrap="false" />
                                            <RowStyle Wrap="false" />
                                        </asp:GridView>
                                    </asp:Panel>
                                    <table class="table" border="0">
                                        <tr>
                                            <td>Expected Amount for Collection
                                            </td>
                                            <td class="text-right">
                                                <strong>
                                                    <asp:Label ID="Label4" CssClass="text-info" runat="server" Text='<%# Bind("price") %>'></asp:Label></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Collected Amount
                                            </td>
                                            <td class="text-right">
                                                <strong>
                                                    <asp:Label ID="Label5" CssClass="text-success" runat="server" Text='<%# Bind("payment") %>'></asp:Label></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Balance
                                            </td>
                                            <td class="text-right">
                                                <strong>
                                                    <asp:Label ID="Label6" CssClass="text-danger" runat="server" Text='<%# Bind("balance") %>'></asp:Label></strong>
                                            </td>
                                        </tr>


                                    </table>
                                    <div class="panel-footer">
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle Wrap="False" />

                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Empty Table!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <EditRowStyle BorderStyle="None" BorderWidth="0px" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                </asp:GridView>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
