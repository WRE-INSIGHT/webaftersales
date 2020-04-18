<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="CallinPage.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.CallinPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Call-in</title>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <h3><strong>Call-in</strong></h3>
    </div>

    <div class="input-group">
        <asp:TextBox ID="callinkey" CssClass="form-control" runat="server"></asp:TextBox>
        <div class="input-group-btn">
            <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">Find</asp:LinkButton>
        </div>
    </div>
    <asp:GridView ID="GridView1" GridLines="None" runat="server" AllowPaging="True" AutoGenerateColumns="False" OnPageIndexChanging="GridView1_PageIndexChanging">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <div class="panel panel-success">
                        <div class="panel-heading">
                             <asp:LinkButton ID="LinkButton2" Font-Size="17px" runat="server">Edit</asp:LinkButton>
                            <div class="navbar-right">
                                <asp:Label ID="callinlbl" Font-Size="16px" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                            </div>
                        </div>
                        <div class="panel-body">
                            <asp:Label ID="callinidlbl" runat="server" Visible="false" Text='<%# Eval("AUTONUM") %>'></asp:Label>
                            <asp:Label ID="projectlbl" Font-Size="20px" runat="server" Text='<%# Bind("PROJECT") %>'></asp:Label>
                            <br />
                            <asp:Label ID="addresslbl" Font-Size="15px" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                            <br />
                            <asp:Label ID="lbldate" Font-Size="13px" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                            <br />
                               <asp:Label ID="statuslbl" Font-Size="15px" runat="server" Text='<%# Bind("STATUS") %>'></asp:Label>

                        
                        </div>
                        <div class="panel-footer">
                            <asp:Label ID="callerlbl" Font-Size="15px" runat="server" Text='<%# Bind("CALLER") %>'></asp:Label>
                        </div>
                    </div>
                </ItemTemplate>

            </asp:TemplateField>
        </Columns>
        <PagerSettings PageButtonCount="8" />
        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
    </asp:GridView>
</asp:Content>
