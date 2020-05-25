<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/DAILYHEALTHPROFILE/DHPmaster.Master" CodeBehind="dhphome.aspx.cs" Inherits="webaftersales.DAILYHEALTHPROFILE.dhphome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Daily Health Profile</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>My Daily Health Profile</strong>   <small>
            <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">new</asp:LinkButton></small></h3>

        <br />
        <div class="row">
            <div class="col-sm-6">
                <div class="input-group">
                    <div class="input-group-addon">DATE</div>
                    <asp:TextBox ID="tboxdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="input-group">
                    <asp:TextBox ID="tboxname" CssClass="form-control" runat="server"></asp:TextBox>
                    <div class="input-group-btn">
                        <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-default"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                    </div>
                </div>
            </div>

        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

    <asp:GridView ID="GridView1" AutoGenerateColumns="false" GridLines="None" runat="server" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                        </div>
                        <div class="panel-body">
                            <asp:Label ID="Label1" Font-Size="XX-Large" runat="server" CssClass="text-info" Text='<%# Bind("DATE") %>'></asp:Label>
                            <h5>KMDI EMPLOYEE DAILY HEALTH PROFILE</h5>
                            <blockquote>
                                <table border="0">

                                    <tr>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">NAME
                                        </td>
                                        <td>
                                            <asp:Label ID="lblname" runat="server" Text='<%# Bind("FULLNAME") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">EMPLOYEE NO.
                                        </td>
                                        <td>
                                            <asp:Label ID="lblempno" runat="server" Text='<%# Bind("EMPNO") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">BIRTHDATE
                                        </td>
                                        <td>
                                            <asp:Label ID="lblbirthday" runat="server" Text='<%# Bind("BIRTHDAY") %>'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="text-muted">AGE
                                        </td>
                                        <td>
                                            <asp:Label ID="lblage" runat="server" Text='<%# Bind("AGE") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </blockquote>
                            <asp:LinkButton ID="LinkButton4" CommandName="page1" CssClass='<%# Eval("page1").ToString() ==  Eval("empno").ToString() ? "btn btn-primary" : "btn btn-warning" %>' runat="server">Page 1</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton5" CommandName="page2" CssClass='<%# Eval("page2").ToString() ==  Eval("empno").ToString() ? "btn btn-primary" : "btn btn-warning" %>' runat="server">Page 2</asp:LinkButton>
                            <asp:LinkButton ID="LinkButton6" CommandName="page3" CssClass='<%# Eval("page3").ToString() ==  Eval("empno").ToString() ? "btn btn-primary" : "btn btn-warning" %>' runat="server">Page 3</asp:LinkButton>
                        </div>
                        <div class="panel-footer">
                          
                        </div>
                    </div>
                    <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                       <asp:Label ID="lbldate" Visible="false" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>

                </ItemTemplate>
            </asp:TemplateField>
        </Columns>

    </asp:GridView>
</asp:Content>
