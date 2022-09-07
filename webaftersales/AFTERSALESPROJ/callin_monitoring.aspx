<%@ Page Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="callin_monitoring.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.callin_monitoring" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Aftersales Call-in Monitoring</title>
    <style>
        .Green {
            border-left: solid 5px green;
            padding-left: 5px;
        }

        .Red {
            border-left: solid 5px red;
            padding-left: 5px;
        }

        .Yellow {
            border-left: solid 5px yellow;
            padding-left: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="well">
        <h3><strong>Aftersales Call-in Monitoring</strong></h3>
    </div>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="well">
                <div class="row">
                    <div class="col-sm-4">
                        <br />
                        <table>
                            <tr>
                                <td style="border-top: solid 10px red; padding-top: 5px; width: 100px; text-align: center;">Unserved
                                </td>
                                <td style="border-top: solid 10px yellow; padding-top: 5px; width: 100px; text-align: center;">Ongoing
                                </td>
                                <td style="border-top: solid 10px green; padding-top: 5px; width: 100px; text-align: center;">Done
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-sm-2">
                        Status:
                        <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server">
                            <asp:ListItem>All</asp:ListItem>
                            <asp:ListItem>Unserved</asp:ListItem>
                            <asp:ListItem>Ongoing</asp:ListItem>
                            <asp:ListItem>Done</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-sm-6">
                        Search Key:
                        <div class="input-group">
                            <asp:TextBox ID="tboxSearch" CssClass="form-control" runat="server"></asp:TextBox>
                            <div class="input-group-btn">
                                <asp:LinkButton ID="LinkButton1" CssClass="btn btn-primary" runat="server" OnClick="LinkButton1_Click">search</asp:LinkButton>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="errorval" CssClass="alert alert-danger" runat="server" />
            <div>

                <asp:GridView ID="GridView1" AutoGenerateColumns="False" CssClass="table" runat="server" AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" OnRowCommand="GridView1_RowCommand">
                    <AlternatingRowStyle BackColor="#DCDCDC" />
                    <Columns>
                        <asp:TemplateField HeaderText="PROJECT">
                            <ItemTemplate>
                                <asp:Panel ID="pnl" runat="server" CssClass='<%# Eval("Callin_Status").ToString() == "Done" ? "Green" : Eval("Callin_Status").ToString() == "Ongoing" ? "Yellow" : "Red" %>'>
                                    <asp:LinkButton ID="LinkButton2" ForeColor="Black" CommandName="showServicing" runat="server" Font-Bold="true" Font-Size="Small" Text='<%# Bind("project") %>'></asp:LinkButton><br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="g1lblfulladd" runat="server" Font-Size="X-Small" Text='<%# Bind("ADDRESS") %>'></asp:Label><br />
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Label ID="lbljo" runat="server" Font-Size="XX-Small" Text='<%# Bind("jo") %>'></asp:Label>
                                </asp:Panel>
                                <asp:Panel ID="Panel2" runat="server" ScrollBars="Auto">
                                    <asp:GridView ID="GridView2" Visible="false" AutoGenerateColumns="false" Font-Size="Smaller" OnRowCommand="GridView2_RowCommand" CssClass="table table-striped" GridLines="Both" runat="server">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Servicing">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblg2Id" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                                                    <asp:Label ID="lblg2Cin" Visible="false" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                                                    <asp:Label ID="lblservicing" runat="server" Text='<%# Bind("SERVICING") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSdate" runat="server" Text='<%# Bind("SDATE") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSstatus" runat="server" Text='<%# Bind("STATUS") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSstatusDate" runat="server" CssClass="text-muted" Text='<%# Bind("STATUSDATE") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton3" CommandName="viewreport" runat="server">report</asp:LinkButton>
                                                    |
                                                        <asp:LinkButton ID="LinkButton4" CommandName="viewphoto" runat="server">photos</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                        <HeaderStyle Wrap="false" />
                                        <RowStyle Wrap="false" />
                                    </asp:GridView>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="DATE/CIN" ItemStyle-Wrap="false">
                            <ItemTemplate>
                                <asp:Label ID="lblDate" runat="server" Font-Size="Small" Text='<%# Bind("DATE") %>'></asp:Label><br />
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                  <asp:Label ID="lblCin" runat="server" CssClass="text-muted" Font-Size="Small" Text='<%# Bind("CIN") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CONCERN">
                            <ItemTemplate>
                                <asp:Label ID="lblConcern" runat="server" Font-Size="Smaller" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("CONCERN").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="CONVERSATION">
                            <ItemTemplate>
                                <asp:Label ID="LBLConversation" runat="server" Font-Size="Smaller" Text='<%# Server.HtmlDecode(Regex.Replace(Eval("CONVERSATION").ToString(), "\r\n|\r|\n", "<br>")) %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                      <asp:TemplateField HeaderText="CALLER">
                          <ItemTemplate>
                               <asp:Label ID="lblCaller" runat="server" Font-Size="Small" Text='<%# Bind("CALLER") %>'></asp:Label>
                          </ItemTemplate>
                      </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="alert alert-danger">
                            <h2><strong>Empty Table!</strong>
                                <small>0 result found</small>
                            </h2>
                        </div>
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                    <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                    <PagerStyle CssClass="GridPager" HorizontalAlign="Left" />
                    <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#0000A9" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#000065" />
                    <HeaderStyle Wrap="False" />
                    <PagerSettings PageButtonCount="15" Position="TopAndBottom" />
                </asp:GridView>
                <asp:Label ID="lblRowNum" runat="server" Font-Size="Large" Text="Results"></asp:Label>

            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
