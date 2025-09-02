defmodule PoeWeb.SimplyBookComponents do
  @moduledoc """
  Provides Simply Book integrations.
  """
  use Phoenix.Component

  @doc """
  Renders the SimplyBook widget.

  ## Examples

      <.simplybook_widget />
  """

  def simplybook_widget(assigns) do
    ~H"""
    <div id="sbw_oef6xc"></div>
    <script type="text/javascript">
      (function(w, d, s, i) {
        var script = d.createElement(s);
        script.async = true;
        script.src = "//widget.simplybook.it/v2/widget/widget.js";
        script.onload = function() {
           new SimplybookWidget({
             "widget_type": "iframe",
             "url": "https:\/\/pieceofenglishbook.simplybook.it",
             "theme": "default",
             "theme_settings": {
               "timeline_hide_unavailable": "1",
               "hide_past_days": "0",
               "timeline_show_end_time": "1",
               "timeline_modern_display": "as_table",
               "sb_base_color": "#fcaef5",
               "display_item_mode": "block",
               "booking_nav_bg_color": "#b024e3",
               "body_bg_color": "#f2f2f2",
               "sb_review_image": "1",
               "sb_review_image_preview": "\/uploads\/pieceofenglishbook\/image_files\/preview\/6729749e8d206bf326f6487bde57b29d.png",
               "dark_font_color": "#474747",
               "light_font_color": "#f5fcff",
               "btn_color_1": "#a935de",
               "sb_company_label_color": "#ffffff",
               "hide_img_mode": "0",
               "show_sidebar": "1",
               "sb_busy": "#c7b3b3",
               "sb_available": "#d4ffee"
             },
             "timeline": "modern",
             "datepicker": "top_calendar",
             "is_rtl": false,
             "app_config": {
               "clear_session": 0,
               "allow_switch_to_ada": 0,
               "predefined": {
                 "provider": "2",
                 "service": "2"
               }
             },
             "container_id": i
           });
        };
        d.head.appendChild(script);
      })(window, document, 'script', 'sbw_oef6xc');
      console.log("foo");
    </script>
    """
  end
end
