<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="cleaningpage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.cleaningpage" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cleaning Proposal</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Cleaning Proposal</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton ID="LinkButton3" CssClass="btn btn-default" runat="server" PostBackUrl="~/AFTERSALESPROJ/addservicing.aspx">back</asp:LinkButton>
        </div>
    </div>
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <h2>
        <strong>
            <asp:Label ID="lblproject" runat="server" Text="Project Name"></asp:Label></strong><br />
        <small>
            <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label></small></h2>
    <br />
    <div class="row">
        <div class="col-sm-6">
            Quote Number
            <asp:TextBox ID="tboxquote" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="tboxquote" ValidationGroup="val1" ID="RequiredFieldValidator1" runat="server" ErrorMessage="quotation number is required" ForeColor="Red">*</asp:RequiredFieldValidator>
        </div>
        <div class="col-sm-6">
            Date<br />
            <asp:TextBox ID="tboxdate" TextMode="Date" CssClass="form-control" runat="server"></asp:TextBox>
            <asp:RequiredFieldValidator ControlToValidate="tboxdate" ValidationGroup="val1" ID="RequiredFieldValidator2" runat="server" ErrorMessage="date is required" ForeColor="Red">*</asp:RequiredFieldValidator>
        </div>

    </div>
    <asp:Button ID="Button1" ValidationGroup="val1" runat="server" CssClass="btn btn-primary" Text="add" OnClick="Button1_Click" />
    <br />
    <h2>Table</h2>
    <asp:Panel ID="Panel1" ScrollBars="Auto" runat="server">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:GridView ID="GridView1" CssClass="table" AutoGenerateColumns="false" runat="server" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton CommandName="myedit" ID="btnedit" runat="server">edit</asp:LinkButton>
                                <asp:LinkButton CommandName="mydelete" ID="btndelete" OnClientClick="return confirm('delete this record?');" runat="server">delete</asp:LinkButton>
                                <asp:LinkButton CommandName="mysave" ValidationGroup="valedit" ID="btnsave" Visible="false" runat="server">save</asp:LinkButton>
                                <asp:LinkButton CommandName="mycancel" ID="btncancel" Visible="false" runat="server">cancel</asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="QUOTATION NO.">
                            <ItemTemplate>
                                <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="lblcin" Visible="false" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                                <asp:Label ID="lblsid" Visible="false" runat="server" Text='<%# Bind("SID") %>'></asp:Label>
                                <asp:Label ID="lblqno" runat="server" Text='<%# Bind("QNO") %>'></asp:Label>
                                <asp:TextBox ID="tboxqnoedit" CssClass="form-control" Text='<%# Bind("QNO") %>' Visible="false" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Visible="false" ControlToValidate="tboxqnoedit" runat="server" ValidationGroup="valedit" ErrorMessage="quotation number is required" ForeColor="Red"></asp:RequiredFieldValidator>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DATE">
                            <ItemTemplate>
                                <asp:Label ID="lblqdate" runat="server" Text='<%# Bind("QDATE") %>'></asp:Label>
                                <asp:TextBox ID="tboxqdateedit" CssClass="form-control" TextMode="Date"  Text='<%# Bind("QDATE") %>' Visible="false" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Visible="false" ControlToValidate="tboxqdateedit" runat="server" ValidationGroup="valedit" ErrorMessage="date is required" ForeColor="Red"></asp:RequiredFieldValidator>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" CommandName="myitem" runat="server">items</asp:LinkButton>
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
