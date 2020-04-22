<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="addservicing.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.addservicing" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>manage schedule</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="page-header">
        <h2>
            <strong>
                <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label></strong><br />
            <small>
                <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label></small></h2>

        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/CallinPage.aspx" runat="server">back</asp:LinkButton>
        </div>

    </div>
    <h4><strong>manage schedule</strong></h4>
    <br />
    <asp:Panel ID="Panel1" runat="server">
        <div class="form-group">
            <table border="0" style="width:100%;">
                <tr>
                    <td style="width:70px">Date
                    </td>
                    <td>
                        <asp:TextBox ID="servicingdate" CssClass="form-control" runat="server" placeholder="mm/dd/yyyy" OnTextChanged="servicingdate_TextChanged"></asp:TextBox>
                    </td>
                    <td>
                        <asp:CompareValidator ID="CompareValidator1" ControlToValidate="servicingdate" Type="Date" Operator="DataTypeCheck"
                            ValidationGroup="val1" runat="server" ErrorMessage="Invalid date format!" ForeColor="Red">*</asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Date is required!"
                            ControlToValidate="servicingdate" ValidationGroup="val1" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Remarks
                    </td>
                    <td>
                        <asp:TextBox ID="remarks" placeholder="remarks" CssClass="form-control" runat="server"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
            </table>
            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" CssClass="alert alert-danger" runat="server" />
        </div>
    </asp:Panel>
    <asp:Button ID="submitbtn" CssClass="btn btn-primary" runat="server" Text="add" ValidationGroup="val1" OnClick="submitbtn_Click" />
    <asp:Button ID="Button4"  CssClass="btn btn-default"  runat="server" Text="refresh" OnClick="Button4_Click" />
    <br />
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>


            <asp:GridView ID="GridView1" GridLines="none" AllowPaging="true" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView1_RowCommand">
                <Columns>


                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label ID="sidlbl" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <asp:LinkButton ID="LinkButton2" CommandName="myedit" runat="server">Edit</asp:LinkButton>

                                    <div class=" navbar-right">
                                        <asp:Label ID="servicingdatelbl" runat="server" Text='<%# Bind("SERVICINGDATE") %>'></asp:Label>
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <asp:Label ID="Label2" runat="server" Font-Size="Large" Text='<%# Bind("SERVICING") %>'></asp:Label>
                                    <table class="table" border="1">
                                        <tr>
                                            <th>Status</th>
                                            <th>Status date</th>
                                            <th>Remarks</th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="statuslbl" runat="server" Text='<%# Bind("STATUS") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="statusdatelbl" runat="server" Text='<%# Bind("STATUSDATE") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="remarkslbl" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label></td>
                                        </tr>

                                        <tr>
                                            <td>
                                                <asp:Button ID="getteambtn" CommandName="myteam" runat="server" CssClass="btn btn-default" Text='<%# Eval("TEAMNAME").ToString() == "" ? "Get team" : Eval("TEAMNAME") %>' /></td>
                                            <td colspan="2">
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("MEMBERS") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Panel ID="Panel2" Visible="false" CssClass="well" runat="server">
                                        Servicing date:<br />
                                        <asp:TextBox ID="servicingdatetbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                        Remarks:<br />
                                        <asp:TextBox ID="remarkstbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                        Status:<br />
                                        <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server">
                                            <asp:ListItem Value="Scheduled" Text="Scheduled"></asp:ListItem>
                                            <asp:ListItem Value="Reschedule" Text="Reschedule"></asp:ListItem>
                                            <asp:ListItem Value="For Costing" Text="For Costing"></asp:ListItem>
                                            <asp:ListItem Value="Done" Text="Done"></asp:ListItem>
                                        </asp:DropDownList>
                                        <br />
                                        Status date:<br />
                                        <asp:TextBox ID="statusdatetbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                        <asp:Button ID="Button1" CommandName="mysave" runat="server" CssClass="btn btn-primary" Text="save" />
                                        <asp:Button ID="Button3" CommandName="mycancel" runat="server" CssClass="btn btn-default" Text="cancel" />
                                    </asp:Panel>
                                </div>
                                <div class="panel-footer">
                                    <asp:Button ID="Button2" runat="server" CommandName="viewreport" Text="view report" CssClass="btn btn-default" />
                                    <div class="navbar-right">
                                        <asp:LinkButton ID="LinkButton3" CommandName="mydelete" runat="server" OnClientClick="return confirm('Are you sure you want to delete this record?');" CssClass="btn btn-default"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>

                                    </div>
                                </div>
                            </div>


                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="alert alert-danger">
                        <h2><strong>Sorry, no data available!</strong>
                            <small>0 result found</small>
                        </h2>
                    </div>
                </EmptyDataTemplate>
                <PagerSettings PageButtonCount="8" />
                <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
            </asp:GridView>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
