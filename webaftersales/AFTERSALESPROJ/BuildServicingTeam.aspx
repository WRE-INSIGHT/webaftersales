<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="BuildServicingTeam.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.BuildServicingTeam" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Build Team</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well text-center">
        <h3><strong>Servicing Team</strong></h3>
    </div>
    <div>
        <div class="row">
            <div class="col-sm-3">
            </div>
            <div class="col-sm-6">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <span>Search</span>
                        <div class="input-group">
                            <asp:TextBox ID="tboxSearch" CssClass="form-control" runat="server"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">search</asp:LinkButton>
                            </div>
                        </div>
                        <br />
                        <div style="overflow-x: auto">
                            <asp:GridView ID="GridView1" AutoGenerateColumns="False" CssClass="table" runat="server" AllowPaging="True"
                                BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                                GridLines="Vertical" DataKeyNames="ID" OnPageIndexChanging="GridView1_PageIndexChanging"
                                OnRowDataBound="GridView1_RowDataBound" PageSize="15">
                                <AlternatingRowStyle BackColor="#DCDCDC" />
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="cboxselect" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Fullname">
                                        <ItemTemplate>
                                            <asp:Label ID="lblId" runat="server" Visible="false" Text='<%#Bind("Id") %>'></asp:Label>
                                            <asp:Label ID="lblFullname" runat="server" Text='<%#Bind("Fullname") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Position">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPosition" runat="server" Text='<%#Bind("Position") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                                <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                <SortedDescendingHeaderStyle BackColor="#000065" />
                                <PagerSettings PageButtonCount="8" Position="TopAndBottom" />
                            </asp:GridView>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-sm-6">
                                <asp:LinkButton ID="LinkButton2" Width="250px" CssClass="btn btn-success" runat="server" OnClick="LinkButton2_Click">SAVE</asp:LinkButton>
                            </div>
                            <div class="col-sm-6">
                                <div class="pull-right">
                                    <asp:LinkButton ID="LinkButton3" Width="250px" CssClass="btn btn-warning" PostBackUrl="~/AFTERSALESPROJ/addservicing.aspx" runat="server">CANCEL</asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
            <div class="col-sm-3">
            </div>
        </div>
    </div>
</asp:Content>
