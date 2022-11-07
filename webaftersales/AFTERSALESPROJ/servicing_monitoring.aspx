<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" CodeBehind="servicing_monitoring.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.servicing_monitoring" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Aftersales Servicing Monitoring</title>
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
        <h3><strong>Aftersales Servicing Monitoring</strong></h3>
    </div>
    <table>
        <tr>
            <td style="border-top: solid 10px red; padding-top: 5px; width: 100px; text-align: center;">No report
            </td>
            <td style="border-top: solid 10px green; padding-top: 5px; width: 100px; text-align: center;">With report
            </td>
        </tr>
    </table>
    <br />
    <div class="well">

        <div class="row">
            <div class="col-sm-4">
                <div class="row">
                    <div class="col-xs-6">
                        <span>start date</span>
                        <asp:TextBox ID="tboxSdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                    <div class="col-xs-6">
                        <span>end date</span>
                        <asp:TextBox ID="tboxEdate" CssClass="form-control" TextMode="Date" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>


            <div class="col-sm-3">
                <span>status</span>
                <asp:DropDownList ID="ddlStatus" CssClass="form-control" runat="server">
                    <asp:ListItem Value="10" Text="All"></asp:ListItem>
                    <asp:ListItem Value="1" Text="With Report"></asp:ListItem>
                    <asp:ListItem Value="0" Text="No Report"></asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm-5">
                <span>Search</span>
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
    <br />

    <asp:GridView ID="GridView1" AutoGenerateColumns="False" AllowPaging="true" CssClass="table" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Vertical" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand">
        <AlternatingRowStyle BackColor="#DCDCDC" />
        <Columns>
            <asp:TemplateField HeaderText="Project">
                <ItemTemplate>
                    <asp:Panel ID="pnl" runat="server" CssClass='<%# Convert.ToInt32(Eval("report").ToString()) > 0 ? "Green" : "Red" %>'>
                        <asp:LinkButton ID="LinkButton2" ForeColor="Black" CommandName="showReport" runat="server" Font-Bold="true" Font-Size="Small" Text='<%# Bind("PROJECT") %>'></asp:LinkButton><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblAddress" runat="server" Font-Size="X-Small" Text='<%# Bind("ADDRESS") %>'></asp:Label><br />
                        <asp:Label ID="lblJO" runat="server" Font-Size="Small" Text='<%# Bind("JO") %>'></asp:Label>



                        <asp:Label ID="cidlbl" Visible="false" Font-Size="13px" runat="server" Text='<%# Bind("CIN") %>'></asp:Label>
                        <asp:Label ID="idlbl" Visible="false" runat="server" Text='<%# Bind("ID") %>'></asp:Label>
                        <asp:Label ID="parentjolbl" runat="server" Visible="false" Text='<%# Bind("PARENT_JO") %>'></asp:Label>
                        <asp:Label ID="colorlbl" Visible="false" runat="server" Text='<%# Bind("PROFILE_FINISH") %>'></asp:Label>
                        <asp:Label ID="datelbl" Visible="false" runat="server" Text='<%# Bind("DATE") %>'></asp:Label>
                        <asp:Label ID="teamlbl" Visible="false" runat="server" Text='<%# Bind("TEAMID") %>'></asp:Label>
                    </asp:Panel>

                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Date">
                <ItemTemplate>
                    <asp:Label ID="lblDate" runat="server" Font-Size="Small" Text='<%# Bind("DATE") %>'></asp:Label>
                    <br />
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-<asp:Label ID="lblServicing" CssClass="text-muted" runat="server" Font-Size="Small" Text='<%# Bind("SERVICING") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Team">
                <ItemTemplate>
                    <asp:Label ID="lblMembers" runat="server" Font-Size="Small" Text='<%# Eval("MEMBERS").ToString().Replace("\n","<br>") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Staus">
                <ItemTemplate>
                    <asp:Label ID="lblStatus" runat="server" ForeColor='<%# Convert.ToInt32(Eval("report").ToString()) > 0 ? System.Drawing.Color.Green : System.Drawing.Color.Red %>' Font-Size="Small" Text='<%# Convert.ToInt32(Eval("report").ToString()) > 0 ? "with report" : "-no report-" %>'></asp:Label>
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



</asp:Content>
