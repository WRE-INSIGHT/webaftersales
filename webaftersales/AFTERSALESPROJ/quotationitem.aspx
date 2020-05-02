<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="quotationitem.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationitem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation Items</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="well">
        <h3><strong>Quotation items</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" PostBackUrl="~/AFTERSALESPROJ/quotation.aspx">back</asp:LinkButton>
        </div>
    </div>
     <h2>
        <strong>
            <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label></strong><br />
        <small>
            <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label></small></h2>
    <asp:Label ID="lblaseno" Font-Size="XX-Large" runat="server" Text="Label"></asp:Label>
    <br />
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />

    <div class="well">
       
            <div class="row">
                <div class="col-sm-4">
                    Item #<br />
                    <asp:TextBox ID="itemnotbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                </div>
                <div class="col-sm-4">
                    K #<br />
                    <asp:TextBox ID="knotbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                </div>
                <div class="col-sm-4">
                    Location<br />
                    <asp:TextBox ID="locationtbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                </div>
            </div>
             <asp:Button ID="Button1" runat="server" Text="add" CssClass="btn btn-primary" OnClick="Button1_Click" />
       
    </div>

    <div class="panel panel-primary">

        <div class="panel-body">
            <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="false" runat="server" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    <asp:LinkButton ID="LinkButton2" ForeColor="Yellow" runat="server" CommandName="myedit">Edit</asp:LinkButton>
                                </div>
                                <div class="panel-body">
                                    <asp:Label ID="locationlbl" runat="server" Font-Size="X-Large" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                    <asp:Label ID="idlbl" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>


                                    <br />
                                    <table class="table">
                                        <tr>
                                            <th>K #</th>
                                            <th>Item #</th>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="knolbl" runat="server" Text='<%# Bind("KNO") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <asp:Label ID="itemnolbl" runat="server" Text='<%# Bind("itemno") %>'></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <asp:Panel ID="Panel1" Visible="false" runat="server">
                                        <div class="panel panel-primary">
                                            <div class="panel-body">
                                                <div class="row">
                                                    <div class="col-sm-4">
                                                        Item #<br />
                                                        <asp:TextBox ID="edititemnotbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                    </div>
                                                    <div class="col-sm-4">
                                                        K #<br />
                                                        <asp:TextBox ID="editknotbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                    </div>
                                                    <div class="col-sm-4">
                                                        Location<br />
                                                        <asp:TextBox ID="editlocationtbox" CssClass="form-control" runat="server"></asp:TextBox><br />
                                                    </div>
                                                </div>
                                                <div class="panel">
                                                    <asp:Button ID="editbtn" runat="server" Text="save" CssClass="btn btn-primary" CommandName="mysave" />
                                                </div>
                                            </div>
                                            <div class="panel-footer">
                                                <asp:Button ID="Button2" runat="server" CommandName="myclose" CssClass="btn btn-default" Text="close" />
                                            </div>
                                        </div>
                                    </asp:Panel>

                                    <asp:GridView ID="GridView2" AutoGenerateColumns="false" ShowHeader="false" GridLines="None" DataSource='<%# Bind("thisparts") %>' runat="server">
                                        <Columns>
                                            <asp:TemplateField>
                                                <ItemTemplate>

                                                    <asp:Label ID="Label2" Font-Size="Large" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label><br />
                                                    Article #:&nbsp;<asp:Label ID="Label3" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label><br />
                                                    <table class="table" border="1">
                                                        <tr>
                                                            <th>mark up</th>
                                                            <th>unit price</th>
                                                            <th>qty</th>
                                                            <th>net price</th>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("MARKUP") %>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("netamount") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div class="panel-footer">
                                    <asp:LinkButton ID="LinkButton3" CssClass="btn btn-danger" runat="server" OnClientClick="return confirm('delete this record?')" CommandName="mydelete"><span class="glyphicon glyphicon-trash">&nbsp;Delete</span></asp:LinkButton>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>
    </div>
</asp:Content>
