{if fetch(user, has_access_to, hash('module', 'mailchimp', 'function', 'subscribe'))}
<form action="#" id="{$block.id}" data-mailchimp="subscription">
    <div style="display: none" class="feedback_text">{$block.custom_attributes.feedback_text}</div>
    <div style="display: none" class="alert"></div>
    <input type="email" name="email_address" placeholder="Email" required />
	<input type="hidden" name="list_id" value="{$block.custom_attributes.list|wash()}" />
	<button type="submit">Subscribe</button>
</form>

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
{/if}