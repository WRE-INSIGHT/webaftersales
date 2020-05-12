<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="quotationitem.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.quotationitem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Quotation Items</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Quotation items</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" runat="server" PostBackUrl="~/AFTERSALESPROJ/quotation.aspx">back</asp:LinkButton>
        </div>
    </div>
    <h2>
        <strong>
            <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label>
        </strong>
        <br />
        <small>
            <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label>
        </small></h2>
    <asp:Label ID="lblaseno" Font-Size="XX-Large" runat="server" Text="Label"></asp:Label>
    <br />
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:UpdatePanel runat="server">
        <ContentTemplate>

            <div class="panel panel-default">
                <div class="panel-body">

                    <div class="row">
                        <div class="col-sm-4">
                            Item #<br />
                            <asp:TextBox ID="itemnotbox" CssClass="form-control" placeholder="Item number" runat="server"></asp:TextBox>
                            <br />
                        </div>
                        <div class="col-sm-4">
                            K #<br />
                            <asp:TextBox ID="knotbox" CssClass="form-control" placeholder="K number" runat="server"></asp:TextBox>
                            <br />
                        </div>
                        <div class="col-sm-4">
                            Location<br />
                            <asp:TextBox ID="locationtbox" CssClass="form-control" placeholder="Location" runat="server"></asp:TextBox>
                            <br />
                        </div>
                    </div>
                    <asp:Button ID="Button1" runat="server" Text="add" CssClass="btn btn-primary" OnClick="Button1_Click" />
                    <asp:Button ID="Button3" runat="server" Text="import" CssClass="btn btn-default" OnClick="Button3_Click" />
                </div>
            </div>

            <asp:Panel ID="Panel2" runat="server" ScrollBars="Horizontal">
                <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="False" runat="server" OnRowCommand="GridView1_RowCommand" ShowHeader="False">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Label ID="idlbl" runat="server" Visible="false" Text='<%# Bind("ID") %>'></asp:Label>
                                <table class="table" border="1">
                                    <tr>

                                        <th>Location</th>
                                        <th>K #</th>
                                        <th>Item #</th>
                                        <th></th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="locationlbl" Font-Size="X-Large" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="knolbl"  runat="server" Text='<%# Bind("KNO") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="itemnolbl" runat="server" Text='<%# Bind("itemno") %>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-default" CommandName="myedit">Edit</asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-default" OnClientClick="return confirm('delete this record?')" CommandName="mydelete">Delete</asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-default" CommandName="parts">Import</asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
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
                                                            <asp:Button ID="Button2" runat="server" CommandName="myclose" CssClass="btn btn-default" Text="close" />
                                                        </div>
                                                    </div>  
                                                </div>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4">
                                            <small>
                                                <asp:GridView ID="GridView2" AutoGenerateColumns="False" DataSource='<%# Bind("thisparts") %>' runat="server" OnRowCommand="GridView2_RowCommand" BackColor="#CCCCCC" BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px" CellPadding="4" CellSpacing="2" ForeColor="Black">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="ARTICLE #">
                                                            <ItemTemplate>
                                                                <asp:Label ID="partsidlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                                <asp:LinkButton runat="server" CommandName="g2mydelete" OnClientClick="return confirm('delete this record?')">Delete</asp:LinkButton>&nbsp;
                                                                        <asp:Label ID="articlenolbl" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="DESCRIPTION">
                                                            <ItemTemplate>
                                                                <asp:Label ID="descriptionlbl" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="%MARKUP">
                                                            <ItemTemplate>
                                                                <asp:Label ID="markuplbl" runat="server" Text='<%# Bind("MARKUP") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="UNIT PRICE">
                                                            <ItemTemplate>
                                                                <asp:Label ID="unitpricelbl" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="QTY">
                                                            <ItemTemplate>
                                                                <asp:Label ID="qtylbl" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                        <asp:TemplateField HeaderText="NET AMOUNT">
                                                            <ItemTemplate>
                                                                <asp:Label ID="netamountlbl" runat="server" Text='<%# Bind("netamount") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                    </Columns>
                                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                                    <RowStyle Wrap="false" BackColor="White" />
                                                    <FooterStyle BackColor="#CCCCCC" />
                                                    <HeaderStyle Wrap="false" BackColor="Black" Font-Bold="True" ForeColor="White" />
                                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                                    <SortedDescendingHeaderStyle BackColor="#383838" />
                                                </asp:GridView>
                                            </small>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>

        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>
