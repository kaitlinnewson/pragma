{**
 * plugins/blocks/subscription/block.tpl
 *
 * Copyright (c) 2014-2020 Simon Fraser University
 * Copyright (c) 2003-2020 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * @brief Display the logged-in user's subscriptions
 *
 *}
{if $individualSubscription}
	{assign var=individualSubscriptionValid value=$individualSubscription->isValid()}
	{assign var=subscriptionStatus value=$individualSubscription->getStatus()}
{/if}
<div class="col-md-3">
	<h2>{translate key="plugins.block.subscription.blockTitle"}</h2>
	<div>
		{if $institutionalSubscription}
			<p>
				{translate key="plugins.block.subscription.providedBy" institutionName=$institutionalSubscription->getInstitutionName()|escape}
			</p>
			<p>
				{translate key="plugins.block.subscription.comingFromIP" ip=$userIP|escape}
			</p>
		{elseif $individualSubscription}
			<p>
				{$individualSubscription->getSubscriptionTypeName()|escape}
			</p>
			{if $individualSubscription->getMembership()}
				<p>({$individualSubscription->getMembership()|escape})</p>
			{/if}
			{if $paymentsEnabled && $acceptSubscriptionPayments && $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_AWAITING_ONLINE_PAYMENT}
				<p>{translate key="subscriptions.status.awaitingOnlinePayment"}</p>
			{elseif $paymentsEnabled && $acceptSubscriptionPayments && $subscriptionStatus == $smarty.const.SUBSCRIPTION_STATUS_AWAITING_MANUAL_PAYMENT}
				<p>{translate key="subscriptions.status.awaitingManualPayment"}</p>
			{elseif $individualSubscription->isNonExpiring()}
				<p>{translate key="subscriptionTypes.nonExpiring"}</p>
			{elseif $individualSubscription->isExpired()}
				<p>{translate key="user.subscriptions.expired" date=$individualSubscription->getDateEnd()|date_format:$dateFormatShort}</p>
			{else}
				<p>{translate key="user.subscriptions.expires" date=$individualSubscription->getDateEnd()|date_format:$dateFormatShort}</p>
			{/if}
		{elseif !$userLoggedIn}
			<p>{translate key="plugins.block.subscription.loginToVerifySubscription"}</p>
		{/if}
		{if $userLoggedIn}
			<p>
				{if $institutionalSubscription || $individualSubscription}
					<a href="{url page="user" op="subscriptions"}">{translate key="user.subscriptions.mySubscriptions"}</a>
				{else}
					{translate key="plugins.block.subscription.subscriptionRequired"}
					<a href="{url page="about" op="subscriptions"}">{translate key="plugins.block.subscription.subscriptionRequired.learnMore"}</a>
				{/if}
			</p>
		{/if}
	</div>
</div>
