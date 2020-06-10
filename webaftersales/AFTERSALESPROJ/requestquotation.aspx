<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="requestquotation.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.requestquotation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Request proposal</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="well">
        <h3><strong>Request proposal</strong></h3>
    </div>
    <asp:ValidationSummary ValidationGroup="val1" CssClass="alert alert-danger" ID="ValidationSummary1" runat="server" />
    <strong>
        <asp:Label ID="lblproject" Font-Size="X-Large" runat="server" Text="Project Name"></asp:Label></strong><br />
    <asp:Label ID="lbladdress" Font-Size="Medium" runat="server" Text="Address"></asp:Label><br />
    <asp:Label ID="lbljo" Font-Size="Medium" runat="server" Text="Job Order No."></asp:Label><br />
    <h2>
        <asp:Label ID="lbldate" runat="server" Text="Date"></asp:Label>
        <small>
            <asp:Label ID="lblservicing" runat="server" Text="Servicing"></asp:Label></small></h2>
    <br />
    <asp:GridView ID="GridView1" GridLines="None" runat="server" AutoGenerateColumns="False" AllowPaging="True" PageSize="5" OnRowCommand="GridView1_RowCommand">
        <Columns>
            <asp:TemplateField HeaderText="Itemno">
                <ItemTemplate>
                    <table class="table" border="1">
                        <tr>
                            <th></th>
                            <th>Itemno</th>
                               <th>Kno</th>
                               <th>Location</th>
                               <th>Dimension</th>
                        </tr>
                        <tr>
                            <td>
                                <asp:LinkButton ID="LinkButton1" runat="server">Request item</asp:LinkButton>
                            </td>
                            <td>
                                <asp:Label ID="lblid" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                <asp:Label ID="lblitemno" runat="server" Text='<%# Bind("ITEMNO") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblkno" runat="server" Text='<%# Bind("KNO") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lbllocation" runat="server" Text='<%# Bind("LOCATION") %>'></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblwidth" runat="server" Text='<%# Bind("WIDTH") %>'></asp:Label>&nbsp;x&nbsp;  
                                                        <asp:Label ID="lblheight" runat="server" Text='<%# Bind("HEIGHT") %>'></asp:Label>
                            </td>
                        </tr>
                    </table>

                    <div class="panel panel-default">
                        <div class="row">
                            <div class="col-sm-6">
                                 <div class="panel-body">
                            Articleno<br />
                            <asp:TextBox ID="tboxarticleno" runat="server"></asp:TextBox><br />
                            Description<br />
                               <asp:TextBox ID="tboxdescription" runat="server"></asp:TextBox><br />
                            <asp:Button ID="Button1" CommandName="myadd" runat="server" Text="add" />
                               <asp:Button ID="Button2" CommandName="myreload" runat="server" Text="reload" />
                        </div>
                            </div>
                                 <div class="col-sm-6">
                                      <asp:GridView ID="GridView3" runat="server"></asp:GridView>
                            </div>
                        </div>
                       
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <PagerSettings PageButtonCount="8" />
        <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
        <EmptyDataTemplate>
            <div class="alert alert-danger">
                <h2><strong>Empty Table!</strong>
                    <small>0 result found</small>
                </h2>
            </div>
        </EmptyDataTemplate>
    </asp:GridView>
</asp:Content>
