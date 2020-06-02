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
                <asp:GridView ID="GridView1" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class="panel panel-primary">
                                    <div class="panel-heading">
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                    </div>
                                    <div class="panel-body">
                                        <asp:Label ID="Label2" runat="server" Font-Size="X-Large" Text='<%# Bind("PROJECT") %>'></asp:Label><br />
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("FULLADD") %>'></asp:Label>
                                    </div>
                                    <div class="panel-footer">
                                   
                                            <table class="table" border="3">
                                                <tr class="text-center">
                                                    <th class="text-info text-center">Total Quotation<br /> Amount
                                                    </th>
                                                    <th class="text-success text-center">Total Aftersales<br /> Payment</th>
                                                    <th class="text-danger text-center">Balance
                                                    </th>
                                                </tr>
                                                <tr class="text-center">
                                                    <td>
                                                        <asp:Label ID="Label4" CssClass="text-info" runat="server" Text='<%# Bind("price") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label5" CssClass="text-success" runat="server" Text='<%# Bind("payment") %>'></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label6" CssClass="text-danger" runat="server" Text='<%# Bind("balance") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                    
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
