<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="quotationForapproval.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationforms.quotationForapproval" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation reports</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Quotation reports</strong></h3>
        <div class="input-group">
            <div class="input-group-addon">
                <asp:CheckBox ID="CheckBox1" runat="server" />&nbsp;for approval
            </div>
            <asp:TextBox ID="tboxsearchkey" CssClass="form-control" runat="server"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

    <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="false" runat="server" AllowPaging="True" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class='<%# Eval("approvedby").ToString() == "" ? "panel panel-danger" : "panel panel-success" %>'>
                        <div class="panel-heading">
                            <asp:Label ID="lblcin" runat="server" Visible="false" Text='<%# Bind("cin") %>'></asp:Label>
                            <asp:Label ID="lblsid" runat="server" Visible="false" Text='<%# Bind("sid") %>'></asp:Label>
                            <asp:Label ID="lblaseno" runat="server" Text='<%# Bind("aseno") %>'></asp:Label>
                        </div>
                        <div class="panel-body">

                            <strong>
                                <asp:LinkButton ID="projectlbl" CommandName="myquotation" CssClass='<%# Eval("approvedby").ToString() == "" ? "text-danger" : "text-success" %>'
                                    Font-Size="X-Large" runat="server" Text='<%# Bind("PROJECT") %>'></asp:LinkButton>
                            </strong>
                            <br />
                            <asp:Label ID="addresslbl" Font-Size="15px" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                            <br />
                            <asp:Label ID="lbljo" CssClass="text-muted" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                            <br />
                            <asp:Label ID="datelbl" Font-Size="XX-Large" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>

                        </div>
                        <div class="panel-footer">
                            <table class="table" border="1">
                                <tr>
                                    <th>Net Price
                                    </th>

                                    <th>Actual Price
                                    </th>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("netprice") %>'></asp:Label>
                                    </td>
                                    <td>
                                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("actualprice") %>'></asp:Label>
                                    </td>
                                </tr>

                            </table>
                        


                        </div>
                            <div class="row">
                                <div class="col-xs-6">
                                    <asp:Image ID="Image1" Width="120" Height="80" runat="server"  AlternateText="no signature"  ImageUrl='<%# "~/Uploads/ASuploads/"+Eval("cin").ToString()+"/"+Eval("sid").ToString()+"/"+Eval("aseno").ToString()+"/signature/PREPAREDBY.jpg" %>' />
                                 <br />   <asp:Label ID="Label4" runat="server" Text='<%# Bind("preparedby") %>'></asp:Label><br />
                                    <span class="text-muted">Prepared by:</span>
                                </div>
                                <div class="col-xs-6">
                                    <asp:Image ID="Image2" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/Uploads/ASuploads/"+Eval("cin").ToString()+"/"+Eval("sid").ToString()+"/"+Eval("aseno").ToString()+"/signature/APPROVEDBY.jpg" %>' />
                                  <br />  <asp:Label ID="Label5" runat="server" Text='<%# Bind("approvedby") %>'></asp:Label><br />
                                    <span class="text-muted">Approved by:</span>
                                </div>
                            </div>
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EmptyDataTemplate>
            <div class="alert alert-info">
                <h3><strong>Empty Table!</strong>
                </h3>
            </div>
        </EmptyDataTemplate>
        <EditRowStyle BorderStyle="None" BorderWidth="0px" />
        <PagerSettings PageButtonCount="8" />
        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
    </asp:GridView>


    <h5><strong class="text-muted">
        <asp:Label ID="lblcountrow" runat="server" Text="Label"></asp:Label></strong> </h5>
</asp:Content>
