<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="pendingpage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.pendingpage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Pending JO</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Pending JO</strong></h3>
        <div class="input-group">
            <asp:TextBox ID="searchtbox" CssClass="form-control" placeholder="project name" runat="server"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="searcbtn2" CssClass="btn btn-default" runat="server" OnClick="searcbtn_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>

    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <br />
    <asp:GridView ID="GridView1" GridLines="None" runat="server" AutoGenerateColumns="False" AllowPaging="True"
        OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" ShowHeader="False"
        HorizontalAlign="Left">
        <Columns>
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <div class="panel panel-warning">
                        <div class="panel-heading">
                            <asp:Label ID="Label1" Font-Size="15px" runat="server" Text='<%# Bind("SERVICING") %>'></asp:Label>
                            <asp:Label ID="cidlbl" CssClass="navbar-right" Font-Size="13px" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <asp:Label ID="idlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>

                                    <asp:Label ID="teamlbl" Visible="false" runat="server" Text='<%# Bind("TEAMID") %>'></asp:Label>
                                    <strong>
                                        <asp:LinkButton ID="projectlbl" Font-Size="20px" CommandName="report" runat="server" Text='<%# Bind("PROJECT") %>'></asp:LinkButton></strong>
                                    <br />
                                    <asp:Label ID="addresslbl" Font-Size="15px" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                                    <br />
                                    <table border="0" class="table">
                                        <tr>
                                            <th>JO
                                            </th>
                                            <th>JO DATE
                                              
                                            </th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="jolbl" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("JODATE") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>

                                    <asp:Label ID="datelbl" Font-Size="XX-Large" runat="server" Text='<%# Bind("DATE") %>'></asp:Label><br />
                                    <table class="table" border="1">

                                        <tr>
                                            <td colspan="2" class="text-center">
                                                <asp:Label ID="Label7" CssClass="text-info" runat="server" Text='<%# Bind("TEAMNAME") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" class="text-center">
                                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("MEMBERS") %>'></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>

                                            <td class="text-center"><small class="text-muted">Status</small>
                                            </td>
                                            <td>
                                                <strong>
                                                    <asp:Label ID="Label12" CssClass=" text-warning" runat="server" Text='<%# Bind("STATUS") %>'></asp:Label></strong>  </td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="text-center"><small class="text-muted">Specified Job</small>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("SPECIFIEDJOB") %>'></asp:Label></td>

                                        </tr>
                                        <tr>
                                            <td class="text-center"><small class="text-muted">Instruction</small>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("INSTRUCTION") %>'></asp:Label></td>

                                        </tr>
                                        <tr>
                                            <td class="text-center"><small class="text-muted">Remarks</small></td>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("REMARKS") %>'></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td class="text-center"><small class="text-muted">Color</small></td>
                                            <td>
                                                <asp:Label ID="colorlbl" runat="server" Text='<%# Bind("PROFILE_FINISH") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                    <br />

                                </div>
                                <div class="col-sm-6">
                                    <div class="panel panel-default">
                                        <table class="table">
                                            <tr>
                                                <th>EIC</th>
                                                <th>AEIC</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Label ID="Label8" runat="server" Text='<%# Eval("EIC") %>'></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label9" runat="server" Text='<%# Eval("AEIC") %>'></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table>
                                                        <tr>
                                                            <td><small class="text-muted">Caller :&nbsp;</small>
                                                                <asp:Label ID="Label2" Font-Size="13px" runat="server" Text='<%# Bind("CALLER") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td><small class="text-muted">Contact person :&nbsp;</small>
                                                                <asp:Label ID="contactpersonlbl" runat="server" Text='<%# Eval("CONTACTPERSON") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td><small class="text-muted">Tel #</small> :&nbsp;</small>
                                                                <asp:Label ID="telnolbl" runat="server" Text='<%# Eval("TELNO") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td><small class="text-muted">Email</small> :&nbsp;</small>
                                                                <asp:Label ID="emaillbl" runat="server" Text='<%# Eval("EMAIL") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td><small class="text-muted">Viber</small> :&nbsp;</small>
                                                                <asp:Label ID="viberlbl" runat="server" Text='<%# Eval("VIBER") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td><small class="text-muted">WhatsApp</small>  :&nbsp;</small>
                                                                <asp:Label ID="whatsapplbl" runat="server" Text='<%# Eval("WHATSAPP") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td><small class="text-muted">Fax #</small>  :&nbsp;</small>
                                                                <asp:Label ID="faxnolbl" runat="server" Text='<%# Eval("FAXNO") %>'></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>


                        </div>

                    </div>

                </ItemTemplate>



            </asp:TemplateField>

        </Columns>
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
</asp:Content>
