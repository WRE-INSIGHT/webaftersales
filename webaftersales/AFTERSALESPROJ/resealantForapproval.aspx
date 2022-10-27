<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="resealantForapproval.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.resealantForapproval" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Re-sealant Proposal approval</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Re-sealant Proposal approval</strong></h3>
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
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="overflow-x: auto">
                <asp:GridView ID="GridView1" GridLines="None" runat="server" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <div class='<%# Eval("notedby").ToString() == "" ? "panel panel-danger" : "panel panel-success" %>'>
                                    <div class="panel-heading">
                                        <asp:Label ID="lblid" runat="server" Visible="false" Text='<%# Bind("qid") %>'></asp:Label>
                                        <asp:Label ID="lblcin" runat="server" Visible="false" Text='<%# Bind("cin") %>'></asp:Label>
                                        <asp:Label ID="lblsid" runat="server" Visible="false" Text='<%# Bind("sid") %>'></asp:Label>
                                        <asp:Label ID="lblqno" runat="server" Text='<%# Bind("qno") %>'></asp:Label>

                                    </div>
                                    <div class="panel-body">
                                        <strong>
                                            <asp:LinkButton ID="projectlbl" CommandName="myresealant" CssClass='<%# Eval("notedby").ToString() == "" ? "text-danger" : "text-success" %>'
                                                Font-Size="X-Large" runat="server" Text='<%# Bind("PROJECT") %>'></asp:LinkButton>
                                        </strong>
                                        <br />
                                        <asp:Label ID="addresslbl" Font-Size="15px" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                                        <br />
                                        <asp:Label ID="datelbl" Font-Size="XX-Large" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                                    </div>
                                    <div class="panel-footer">
                                        <table class="table" border="1">
                                            <th>Total amount 
                                            </th>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label3" Font-Size="Large" runat="server" Text='<%# Bind("TOTALAMOUNT") %>'></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="row">
                                        <div class="col-xs-6">
                                            <asp:Image ID="Image1" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/Uploads/ASuploads/"+Eval("cin").ToString()+"/"+Eval("sid").ToString()+"/RESEALANT/"+Eval("qno").ToString()+"/signature/PREPAREDBY.jpg" %>' />
                                            <br />
                                            <b>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("preparedby") %>'></asp:Label></b>
                                            <br />
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("preparedbytitle") %>'></asp:Label><br />
                                            <span class="text-muted">Prepared by:</span>
                                        </div>
                                        <div class="col-xs-6">
                                            <asp:Image ID="Image2" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/Uploads/ASuploads/"+Eval("cin").ToString()+"/"+Eval("sid").ToString()+"/RESEALANT/"+Eval("qno").ToString()+"/signature/NOTEDBY.jpg" %>' />
                                            <br />
                                            <b>
                                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("notedby") %>'></asp:Label></b>
                                            <br />
                                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("notedbytitle") %>'></asp:Label>
                                            <br />
                                            <span class="text-muted">Approved by:</span>
                                        </div>
                                    </div>
                                </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle Wrap="false" />
                    <RowStyle Wrap="false" />
                    <PagerSettings PageButtonCount="8" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                    <EmptyDataTemplate>
                        <div class="alert alert-info">
                            <h3><strong>Empty Table!</strong>
                            </h3>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <h5><strong class="text-muted">
        <asp:Label ID="lblcountrow" runat="server" Text="Label"></asp:Label></strong> </h5>
</asp:Content>


