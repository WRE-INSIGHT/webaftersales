<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="quotationForapproval.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationforms.quotationForapproval" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation reports</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Quotation reports</strong></h3>
        <div class="row">
            <div class="col-sm-3">
                For approval
                <asp:DropDownList ID="ddlForApproval" CssClass="form-control" runat="server">
                    <asp:ListItem Text="For Approval" Value="1"></asp:ListItem>
                    <asp:ListItem Text="All" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-3">
                Lock
                <asp:DropDownList ID="ddlLockSearch" CssClass="form-control" runat="server">
                    <asp:ListItem Text="no" Value="0"></asp:ListItem>
                    <asp:ListItem Text="yes" Value="1"></asp:ListItem>
                    <asp:ListItem Text="All" Value="10"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-6">
                Search
                    <div class="input-group">
                        <asp:TextBox ID="tboxsearchkey" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                        </div>
                    </div>
            </div>
        </div>

    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="row">
                <div class="col-sm-2">
                </div>
                <div class="col-sm-8">
                    <div style="overflow-x: auto">
                        <asp:GridView ID="GridView1" GridLines="None" Width="100%" AutoGenerateColumns="false" runat="server" AllowPaging="True" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowDataBound="GridView1_RowDataBound">
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
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <table class="table" border="1">
                                                            <tr>
                                                                <th>Quoted Amount
                                                                </th>

                                                                <th>Bill Amount
                                                                </th>
                                                                <th>Discounted Price</th>
                                                                <th></th>
                                                                <th>Waived</th>
                                                                <th>Lock</th>
                                                                <th></th>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("netprice") %>'></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("actualprice") %>'></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblid" runat="server" Visible="false" Text='<%# Bind("id") %>'></asp:Label>
                                                                    <asp:Label ID="lbldiscountedprice" runat="server" Text='<%# Bind("discountedpriceFormatted") %>'></asp:Label>
                                                                    <asp:TextBox ID="tboxdiscountedprice" CssClass="form-control" Visible="false" TextMode="Number" Text='<%# Bind("discountedprice") %>' runat="server"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:LinkButton ID="LinkButton2" CommandName="proofOfPayment" CssClass="btn btn-primary" runat="server">photos</asp:LinkButton>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblwaived" runat="server" Text='<%# Bind("waived") %>'></asp:Label>
                                                                    <asp:DropDownList ID="ddlwaived" CssClass="form-control" Visible="false" Text='<%# Bind("waived") %>' runat="server">
                                                                        <asp:ListItem>yes</asp:ListItem>
                                                                        <asp:ListItem>no</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lbllock" runat="server" Text='<%# Eval("lock").ToString() == "1" ? "yes" : "no" %>'></asp:Label>
                                                                    <asp:DropDownList ID="ddllock" CssClass="form-control" Visible="false" Text='<%# Bind("lock") %>' runat="server">
                                                                        <asp:ListItem Value="0" Text="no"></asp:ListItem>
                                                                        <asp:ListItem Value="1" Text="yes"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:LinkButton ID="btnEdit" CommandName="myEdit" runat="server">Edit</asp:LinkButton>
                                                                    <asp:LinkButton ID="btnSave" CommandName="mySave" Visible="false" runat="server">Save</asp:LinkButton>
                                                                    |
                                        <asp:LinkButton ID="btnCancel" CommandName="myCancel" Visible="false" runat="server">Cancel</asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>

                                            </div>
                                            <div class="row">
                                                <div class="col-xs-6">
                                                    <asp:Image ID="Image1" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/Aftersales/ASuploads/"+Eval("cin").ToString()+"/"+Eval("sid").ToString()+"/"+Eval("aseno").ToString()+"/signature/PREPAREDBY.jpg" %>' />
                                                    <br />
                                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("preparedby") %>'></asp:Label><br />
                                                    <span class="text-muted">Prepared by:</span>
                                                </div>
                                                <div class="col-xs-6">
                                                    <asp:Image ID="Image2" Width="120" Height="80" runat="server" AlternateText="no signature" ImageUrl='<%# "~/KMDI_FILES/Aftersales/ASuploads/"+Eval("cin").ToString()+"/"+Eval("sid").ToString()+"/"+Eval("aseno").ToString()+"/signature/APPROVEDBY.jpg" %>' />
                                                    <br />
                                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("approvedby") %>'></asp:Label><br />
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
                    </div>
                </div>
                <div class="col-sm-2">
                </div>
            </div>

            <h5><strong class="text-muted">
                <asp:Label ID="lblcountrow" runat="server" Text="Label"></asp:Label></strong> </h5>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
