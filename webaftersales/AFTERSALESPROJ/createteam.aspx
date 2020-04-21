<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="createteam.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.createteam" %>


<asp:Content ID="content1" runat="server" ContentPlaceHolderID="head">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>assign team</title>
</asp:Content>

<asp:Content ID="content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div class="page-header">
        <h3><strong>Team assignment</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/addservicing.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-6">
            <header>Create team</header>
            <table class="table" border="0">
                <tr>
                    <td>Team name
                    </td>
                    <td>
                        <asp:TextBox ID="teamnametbox" placeholder="team name" CssClass="form-control" runat="server"></asp:TextBox>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator CssClass="alert alert-danger" ID="RequiredFieldValidator1" ControlToValidate="teamnametbox" runat="server" ErrorMessage="team name is required" ValidationGroup="val1">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>Personnel
                    </td>
                    <td>
                        <asp:DropDownList ID="personneldl" placeholder="select people" CssClass="form-control" runat="server"></asp:DropDownList>
                    </td>
                    <td>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="personneldl" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" ErrorMessage="need member">*</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" ValidationGroup="val1" runat="server"><span class="glyphicon glyphicon-save"></span></asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
                    </td>
                </tr>
            </table>

            <div class="panel panel-primary">
                <div class="panel-heading">
                    Members
                </div>
                <div class=" panel-body">
                    <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="false" runat="server">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>

                                    <table class="table" border="1">
                                        <tr>
                                            <td>
                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("FULLNAME") %>'></asp:Label></td>
                                            <td>
                                                <asp:Button ID="Button1" runat="server" CssClass="btn btn-default" Text="remove" /></td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="panel-footer">
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Teams
                </div>
                <div class="panel-body">
                    <div class="input-group">
                        <asp:TextBox ID="keytbox" CssClass="form-control" runat="server"></asp:TextBox>
                        <div class="input-group-btn">
                            <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" runat="server" OnClick="LinkButton3_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
                        </div>
                    </div>
                    <asp:GridView ID="GridView2" AutoGenerateColumns="false" GridLines="None" AllowPaging="true" runat="server" OnPageIndexChanging="GridView2_PageIndexChanging" PageSize="6">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <table class="table" border="1">
                                        <tr>
                                            <td>
                                                   <asp:Label ID="Label2" runat="server" Text='<%# Bind("TEAMNAME") %>'></asp:Label>
                                            </td>
                                            <td>
                                                     <asp:Label ID="Label3" runat="server" Text='<%# Bind("MEMBERS") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Button ID="Button2" CssClass="btn btn-default" runat="server" Text="Button" />
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Label ID="Label4" Visible="false" runat="server" Text='<%# Bind("TID") %>'></asp:Label>
                                 
                               
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerSettings PageButtonCount="8" />
                        <PagerStyle CssClass="GridPager" HorizontalAlign="Center" />
                    </asp:GridView>
                </div>
                <div class="panel-footer">
                </div>
            </div>
        </div>
    </div>
</asp:Content>
