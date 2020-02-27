<%@ Page Title="" Language="C#" MasterPageFile="~/AFTERSALESPROJ/ASmasterpage.Master" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="webaftersales.AFTERSALESPROJ.WebForm2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <link href="css/CSSreporting.css" rel="stylesheet" />
    <style type="text/css">
        .Background {
            background-color: Black;
            filter: alpha(opacity=90);
            opacity: 0.8;
        }

        .Popup {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
            /*background-color: #FFFFFF;*/
            border-width: 3px;
            border-style: solid;
            border-color: black;
            /*padding-top: 10px;
            padding-left: 10px;*/
            width: 500px;
            height: 500px;
        }

        .lbl {
            font-size: 16px;
            font-style: italic;
            font-weight: bold;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
            <Columns>
               <%-- <asp:TemplateField>
                    <ItemTemplate>
                        <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("ADDRESS") %>'></asp:Label>
                    </ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="PROJECT" DataField="PROJECT" />
                     <asp:BoundField HeaderText="ADDRESS" DataField="ADDRESS" />--%>
                    <asp:BoundField HeaderText="location" DataField="location" />
                  <asp:BoundField HeaderText="specification" DataField="specification" />
            </Columns>
      </asp:GridView>

      
</asp:Content>
