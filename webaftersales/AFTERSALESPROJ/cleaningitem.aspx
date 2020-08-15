<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="cleaningitem.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.cleaningitem" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cleaning Item</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Cleaning Proposal Item</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-default" PostBackUrl="~/AFTERSALESPROJ/cleaningpage.aspx" runat="server">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="panel panel-default">
        <div class="panel-heading">
        </div>
        <div class="panel-body">
            <div class="row">
                <div class="col-sm-6">
                    Location<br />
                    <asp:TextBox ID="tboxlocation" CssClass=" form-control" runat="server"></asp:TextBox>
                    Area<br />
                    <asp:TextBox ID="tboxarea" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                </div>
                <div class="col-sm-6">
                    Unit Price           <asp:RequiredFieldValidator ID="RequiredFieldValidator2" ControlToValidate="tboxunitprice" ValidationGroup="val1" runat="server" ErrorMessage="unit price is required!" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                    <asp:TextBox ID="tboxunitprice" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                    Qty   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="tboxqty" ValidationGroup="val1" runat="server" ErrorMessage="qty is required!" ForeColor="Red">*</asp:RequiredFieldValidator><br />
                    <asp:TextBox ID="tboxqty" TextMode="Number" CssClass=" form-control" runat="server"></asp:TextBox>
                </div>
            </div>
            <br />
            <asp:LinkButton ID="LinkButton2" CssClass="btn btn-primary" runat="server" ValidationGroup="val1" OnClick="LinkButton2_Click">add</asp:LinkButton>
        </div>
        <div class="panel-footer">
        </div>
    </div>

    <asp:Panel ID="Panel1" runat="server" ScrollBars="Auto">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" CssClass="table" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton CssClass="btn btn-warning" CommandName="myedit" ID="btnedit" runat="server">edit</asp:LinkButton>
                                <asp:LinkButton CssClass="btn btn-danger" CommandName="mydelete" ID="btndelete" OnClientClick="return confirm('delete this record?');" runat="server">delete</asp:LinkButton>
                                <asp:LinkButton CssClass="btn btn-success" CommandName="mysave" ValidationGroup="valedit" ID="btnsave" Visible="false" runat="server">save</asp:LinkButton>
                                <asp:LinkButton CssClass="btn btn-danger" CommandName="mycancel" ID="btncancel" Visible="false" runat="server">cancel</asp:LinkButton>
                                <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="lbliid" Visible="false" runat="server" Text='<%# Bind("IID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="LOCATION">
                            <ItemTemplate>
                                <asp:Label ID="lbllocation" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                                <asp:TextBox ID="tboxlocationedit" CssClass="form-control" Visible="false" runat="server" Text='<%# Bind("LOCATION") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="AREA">
                            <ItemTemplate>
                                <asp:Label ID="lblarea" runat="server" Text='<%# Bind("AREA") %>'></asp:Label>
                                <asp:TextBox ID="tboxareaedit" CssClass="form-control" TextMode="Number" Visible="false" runat="server" Text='<%# Bind("AREA") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="UNIT PRICE">
                            <ItemTemplate>
                                <asp:Label ID="lblunitprice" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:Label>
                                <asp:TextBox ID="tboxunitpriceedit" CssClass="form-control" TextMode="Number" Visible="false" runat="server" Text='<%# Bind("UNITPRICE") %>'></asp:TextBox>
                                      <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Visible="false" ControlToValidate="tboxunitpriceedit" ValidationGroup="valedit" runat="server" ErrorMessage="unit price is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="QTY">
                            <ItemTemplate>
                                <asp:Label ID="lblqty" runat="server" Text='<%# Bind("QTY") %>'></asp:Label>
                                <asp:TextBox ID="tboxqtyedit" CssClass="form-control" TextMode="Number" Visible="false" runat="server" Text='<%# Bind("QTY") %>'></asp:TextBox>
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Visible="false" ControlToValidate="tboxqtyedit" ValidationGroup="valedit" runat="server" ErrorMessage="qty is required!" ForeColor="Red">*</asp:RequiredFieldValidator>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="TOTAL AMOUNT">
                            <ItemTemplate>
                                <asp:Label ID="lbltotalamount" runat="server" Text='<%# Bind("TOTALAMOUNT") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle Wrap="false" />
                    <HeaderStyle Wrap="false" />
                </asp:GridView>
                <asp:ValidationSummary ID="ValidationSummary2" ValidationGroup="valedit" CssClass="alert alert-danger" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>

</asp:Content>
