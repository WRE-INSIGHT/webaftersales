<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="pdfuploads.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.pdfuploads" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PDF files</title>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>PDF files</strong></h3>
        <div class="navbar-right">
            <asp:LinkButton CssClass="btn btn-default" ID="LinkButton1" runat="server" PostBackUrl="~/AFTERSALESPROJ/quotation.aspx">back</asp:LinkButton>
        </div>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <div class="panel panel-primary">
        <div class="panel-heading">
            PDF files
        </div>
        <div class="panel-body">
            <asp:Panel ID="Panel3" runat="server">
                <div class="navbar-left">
                    <label class="btn btn-default">
                        <span><strong>Upload Image</strong></span>
                        <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="True"></asp:FileUpload>
                    </label>
                </div>
                <div class="navbar-right">
                    <asp:Button ID="Button1" runat="server" Text="Upload PDF" ValidationGroup="g1" CssClass="btn btn-default" OnClick="Button1_Click" />
                </div>
            </asp:Panel>
            <br />
            <br />

            <asp:Panel ID="Panel2" runat="server">
                <div class="alert alert-danger">
                    <asp:Label ID="errorlbl" runat="server" Text=""></asp:Label>
                </div>
            </asp:Panel>

        </div>
        <asp:Panel ID="Panel1" runat="server" BorderStyle="None" BackColor="#333333">
        </asp:Panel>
        <asp:GridView ID="GridView1" GridLines="None" ShowHeader="false" runat="server" AutoGenerateColumns="false" OnRowCommand="GridView1_RowCommand">
            <Columns>
                <asp:TemplateField HeaderText="File Name">
                    <ItemTemplate>
                        <asp:Image ID="Image1" ImageUrl="~/AFTERSALESPROJ/images/pdf-icon.png" Width="40" Height="40" runat="server" />
                        <asp:Label ID="lblid" runat="server" Text='<%# Bind("ID") %>' Visible="false"></asp:Label>
                        <asp:LinkButton ID="lbtnfilename" Font-Size="X-Large" CssClass="text-muted" runat="server" CommandName="viewfile" Text='<%# Bind("FILENAME") %>'></asp:LinkButton>&nbsp;&nbsp;
                           <asp:LinkButton ID="LinkButton3" CssClass="text-danger" Font-Size="X-Large" CommandName="mydelete" runat="server" OnClientClick="return confirm('delete this file?');"><span class="glyphicon glyphicon-remove-sign"></span></asp:LinkButton>
                        <asp:Label ID="lblfilepath" runat="server" Text='<%# Bind("FILEPATH") %>' Visible="false"></asp:Label>
                        <br />
                        <br />
                    </ItemTemplate>
                </asp:TemplateField>
            
            </Columns>
        </asp:GridView>

        <div class="panel-footer">
        </div>
    </div>
</asp:Content>
