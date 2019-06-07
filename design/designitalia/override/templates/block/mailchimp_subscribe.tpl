{if fetch(user, has_access_to, hash('module', 'mailchimp', 'function', 'subscribe'))}
<div class="Grid u-background-80 u-margin-bottom-m u-padding-all-xxl">
    <div class="Grid-cell u-sizeFull">
        <div class="u-padding-all-l u-layoutCenter u-textCenter">
            <h3 class="u-text-h3 u-color-white">{$block.name|wash()}</h3>

            <form class="Form u-layoutCenter u-layout-prose" action="#" method="get" data-mailchimp="subscription">

                <div style="display: none" class="u-padding-all-l u-margin-bottom-l u-background-white feedback_text">{$block.custom_attributes.feedback_text}</div>
                <div style="display: none" class="u-padding-all-l u-margin-bottom-l u-background-white alert"></div>

                <div class="Form-field Form-field--withPlaceholder Grid u-background-white u-color-grey-30 u-borderRadius-s u-borderShadow-m">
                    <button class="Grid-cell u-sizeFit Icon-mail u-color-grey-40 u-text-r-m u-padding-all-s u-textWeight-400" role="presentation" aria-hidden="true"></button>
                    <input class="Form-input Form-input--ultraLean Grid-cell u-sizeFill u-text-r-s u-color-black u-text-r-xs u-borderHideFocus" required="required" id="{$block.id}-email_address" name="email_address" type="email">
                    <label class="Form-label u-color-grey-40 u-padding-left-xxl" for="{$block.id}-email_address">
                        <span class="u-hidden u-md-inline u-lg-inline">Indirizzo email</span>
                    </label>
                    <button type="submit" class="Grid-cell u-sizeFit u-background-teal-30 u-color-white u-textWeight-600 u-padding-r-left u-padding-r-right u-textUppercase u-borderRadius-s">
                        Iscriviti
                    </button>
                    <input type="hidden" name="list_id" value="{$block.custom_attributes.list|wash()}" />
                </div>
            </form>

        </div>
    </div>
{run-once}
{literal}
<script>
    $(document).ready(function () {
        $('[data-mailchimp="subscription"]').submit(function (e) {
            var form = $(this);
            var feedbackContainer = form.find('.alert').removeClass('alert-warning alert-success').html('').hide();
            var feedbackText = form.find('.feedback_text').html();
            $.ajax({
                url: "{/literal}{'mailchimp/subscribe/'|ezurl(no)}{literal}",
                type: 'GET',
                data: form.serialize(),
                success: function (data) {
                    if (data.error){
                        feedbackContainer.html(data.error).addClass('alert-warning ').show();
                    }else{
                        feedbackContainer.html(feedbackText).addClass('alert-warning ').show();
                    }
                }
            });
            e.preventDefault();
        });
    });
</script>
{/literal}
{/run-once}
</div>
{/if}