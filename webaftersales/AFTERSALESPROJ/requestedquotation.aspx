<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="requestedquotation.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.requestedquotation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Requested proposal</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Requested proposal</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/quotation.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
        <asp:GridView ID="GridView1" GridLines="None" AutoGenerateColumns="false" runat="server">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Label ID="Label2" Visible="false" runat="server" Text='<%# Bind("id") %>'></asp:Label>
                        <asp:Label ID="Label3" Visible="false" runat="server" Text='<%# Bind("sid") %>'></asp:Label>
                        <table border="1" class="table">

                            <tr>
                                <th>K#</th>
                                <th>ITEM#</th>
                                <th>LOCATION</th>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("kno") %>'></asp:Label></td>
                                <td>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("itemno") %>'></asp:Label></td>
                                <td>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("location") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <small>
                                        <asp:GridView ID="GridView2" GridLines="Horizontal" runat="server" AutoGenerateColumns="false" DataSource='<%# Bind("thisparts") %>'>
                                            <Columns>

                                                <asp:TemplateField HeaderText="ARTICLE#">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label7" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                        <asp:Label ID="Label8" Visible="false" runat="server" Text='<%# Bind("IID") %>'></asp:Label>
                                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("ARTICLENO") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="DESCRIPTION">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="QTY">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="UNIT PRICE">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                            </Columns>
                                            <HeaderStyle Wrap="False" />
                                            <RowStyle Wrap="False" />
                                        </asp:GridView>
                                    </small>
                                </td>
                            </tr>
                        </table>

                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle Wrap="False" />
            <RowStyle Wrap="False" />
        </asp:GridView>
    </asp:Panel>

    <div class="panel panel-default">
        <div class="panel-body">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Label ID="Label4" Font-Size="X-Large" runat="server" Text="manual input"></asp:Label><br />
                    <div class="row">
                        <div class="col-sm-6">
                            Quotation date
                               <asp:CompareValidator ID="CompareValidator1" ControlToValidate="datetbox" Type="Date" Operator="DataTypeCheck"
                                   ValidationGroup="newval" runat="server" ErrorMessage="Invalid date format!" ForeColor="Red">*</asp:CompareValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Date is required!"
                                ControlToValidate="datetbox" ValidationGroup="newval" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                            <asp:TextBox ID="datetbox" TextMode="Date" placeholder="Date" CssClass="form-control" runat="server"></asp:TextBox><br />
                            ASE#<br />
                            <asp:TextBox ID="asetbox" placeholder="ASE" CssClass="form-control" runat="server"></asp:TextBox><br />
                        </div>
                        <div class="col-sm-6">
                            Other charges<br />
                            <asp:TextBox ID="othertbox" placeholder="Other charges" CssClass="form-control" runat="server"></asp:TextBox><br />
                            Particular<br />
                            <asp:TextBox ID="particulartbox" placeholder="Particular" CssClass="form-control" runat="server"></asp:TextBox><br />
                        </div>

                    </div>

                    <asp:Button ID="newbtn" OnClick="newbtn_click" CssClass="btn btn-primary" ValidationGroup="newval" runat="server" Text="add" />
                    <asp:ValidationSummary ID="valsummary" ValidationGroup="newval" CssClass="alert alert-danger" runat="server" />

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

</asp:Content>
