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
        <div class="col-sm-4">
            <header>Create team</header>
            <br />
            Team name<br />
            <asp:TextBox ID="teamnametbox" placeholder="team name" CssClass="form-control" runat="server"></asp:TextBox>
            <br />
            <asp:RequiredFieldValidator CssClass="alert alert-danger" ID="RequiredFieldValidator1" runat="server" ErrorMessage="team name is required" ValidationGroup="val1"></asp:RequiredFieldValidator>
            <br />
            Personnel<br />
            <asp:DropDownList ID="personneldl" placeholder="select people" CssClass="form-control" runat="server"></asp:DropDownList>
            <br />
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server"><span class="glyphicon glyphicon-save"></span></asp:LinkButton>
            <asp:ValidationSummary ID="ValidationSummary1" CssClass="alert alert-danger" ValidationGroup="val1" runat="server" />
            <br />
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
        <div class="col-sm-4">
        </div>
        <div class="col-sm-4">
        </div>
    </div>
</asp:Content>
