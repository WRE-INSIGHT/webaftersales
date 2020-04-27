<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="homePage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.homePage" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Home</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%--   <div class="page-header">
        <h3><strong>Kenneth and Mock</strong><small> WINDOWS AND DOORS</small></h3>
    </div>--%>
    <div class="well">
        <h3><strong>Kenneth and Mock</strong><small> WINDOWS AND DOORS</small></h3>
        <div class="input-group">
            <asp:TextBox ID="searchtbox" CssClass="form-control" placeholder="project name" runat="server" OnTextChanged="searchtbox_TextChanged"></asp:TextBox>
            <div class="input-group-btn">
                <asp:LinkButton ID="searcbtn2" CssClass="btn btn-primary" runat="server" OnClick="searcbtn_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            </div>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="val1" CssClass="alert alert-danger" runat="server" />

    <div>
        <h4><small>Job orders</small></h4>
    </div>
    <asp:GridView ID="GridView1" GridLines="None" runat="server" AutoGenerateColumns="False" AllowPaging="True"
        OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" ShowHeader="False"
        HorizontalAlign="Left">
        <Columns>
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <div class="panel panel-primary">
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
                                            <td>  <asp:Label ID="jolbl" runat="server" Text='<%# Bind("JO") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("JODATE") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                         
                                    <asp:Label ID="datelbl"  Font-Size="XX-Large" runat="server" Text='<%# Bind("DATE") %>'></asp:Label><br />

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
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table>
                                                        <tr>
                                                            <td class="text-muted">Contact person</td>
                                                            <td>
                                                                <asp:Label ID="contactpersonlbl" runat="server" Text='<%# Eval("CONTACTPERSON") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="text-muted">Tel #</td>
                                                            <td>
                                                                <asp:Label ID="telnolbl" runat="server" Text='<%# Eval("TELNO") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="text-muted">Fax #</td>
                                                            <td>
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
                        <div class="panel-footer">
                            <asp:Label ID="Label11" CssClass="text-muted" runat="server" Text="caller "></asp:Label>
                            <asp:Label ID="Label2" Font-Size="13px" runat="server" Text='<%# Bind("CALLER") %>'></asp:Label>
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
        <EditRowStyle BorderStyle="None" BorderWidth="0px" />
        <PagerSettings PageButtonCount="8" />
        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
        <%--   <RowStyle Font-Names="Segoe UI" Font-Size="10pt" Height="120px" CssClass="rowstyle" />--%>
    </asp:GridView>



</asp:Content>
