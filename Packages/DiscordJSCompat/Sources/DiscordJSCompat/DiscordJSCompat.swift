import Foundation

public final class Base {}
public final class BaseClient: Base {}
public final class BaseInteraction: Base {}
public final class BaseManager: Base {}
public final class CachedManager: BaseManager {}
public final class DataManager: BaseManager {}
public final class Collector {}
public final class Collection<Key: Hashable, Value> {}
public final class LimitedCollection<Key: Hashable, Value>: Collection<Key, Value> {}

public final class Client: BaseClient {}
public final class ClientApplication {}
public final class ClientPresence {}
public final class ClientUser {}
public final class ClientVoiceManager {}

public final class REST {}
public final class GatewayRateLimitError: Error {}
public final class RateLimitError: Error {}
public final class HTTPError: Error {}
public final class DiscordAPIError: Error {}
public final class DiscordjsError: Error {}
public final class DiscordjsRangeError: Error {}
public final class DiscordjsTypeError: Error {}

public class BitField {}
public final class IntentsBitField: BitField {}
public final class PermissionsBitField: BitField {}
public final class ChannelFlagsBitField: BitField {}
public final class MessageFlagsBitField: BitField {}
public final class InviteFlagsBitField: BitField {}
public final class RoleFlagsBitField: BitField {}
public final class SKUFlagsBitField: BitField {}
public final class UserFlagsBitField: BitField {}
public final class ActivityFlagsBitField: BitField {}
public final class AttachmentFlagsBitField: BitField {}
public final class ApplicationFlagsBitField: BitField {}
public final class GuildMemberFlagsBitField: BitField {}
public final class SystemChannelFlagsBitField: BitField {}
public final class ThreadMemberFlagsBitField: BitField {}

public final class CDN {}
public final class Options {}
public final class Formatters {}

public struct ActionRow<Component> {
    public var components: [Component]
    public init(components: [Component]) { self.components = components }
}

public final class ActionRowBuilder {}
public final class Component {}
public final class ComponentBuilder {}
public final class ContainerComponent: Component {}
public final class ContainerBuilder: ComponentBuilder {}
public final class SeparatorComponent: Component {}
public final class SeparatorBuilder: ComponentBuilder {}
public final class SectionComponent: Component {}
public final class SectionBuilder: ComponentBuilder {}
public final class LabelComponent: Component {}
public final class LabelBuilder: ComponentBuilder {}
public final class ThumbnailComponent: Component {}
public final class ThumbnailBuilder: ComponentBuilder {}
public final class TextDisplayComponent: Component {}
public final class TextDisplayBuilder: ComponentBuilder {}
public final class FileComponent: Component {}
public final class FileBuilder: ComponentBuilder {}
public final class FileUploadBuilder: ComponentBuilder {}
public final class MediaGalleryComponent: Component {}
public final class MediaGalleryBuilder: ComponentBuilder {}
public final class MediaGalleryItem {}
public final class MediaGalleryItemBuilder {}
public final class UnfurledMediaItem {}

public final class BaseSelectMenuComponent: Component {}
public final class BaseSelectMenuBuilder: ComponentBuilder {}
public final class StringSelectMenuComponent: BaseSelectMenuComponent {}
public final class StringSelectMenuBuilder: BaseSelectMenuBuilder {}
public final class StringSelectMenuOptionBuilder {}
public final class ChannelSelectMenuComponent: BaseSelectMenuComponent {}
public final class ChannelSelectMenuBuilder: BaseSelectMenuBuilder {}
public final class RoleSelectMenuComponent: BaseSelectMenuComponent {}
public final class RoleSelectMenuBuilder: BaseSelectMenuBuilder {}
public final class UserSelectMenuComponent: BaseSelectMenuComponent {}
public final class UserSelectMenuBuilder: BaseSelectMenuBuilder {}
public final class MentionableSelectMenuComponent: BaseSelectMenuComponent {}
public final class MentionableSelectMenuBuilder: BaseSelectMenuBuilder {}

public final class ButtonComponent: Component {}
public final class ButtonBuilder: ComponentBuilder {}
public final class CheckboxBuilder: ComponentBuilder {}
public final class CheckboxGroupBuilder: ComponentBuilder {}
public final class CheckboxGroupOptionBuilder {}
public final class RadioGroupBuilder: ComponentBuilder {}
public final class RadioGroupOptionBuilder {}
public final class TextInputComponent: Component {}
public final class TextInputBuilder: ComponentBuilder {}
public final class ModalBuilder {}

public final class Embed {}
public final class EmbedBuilder {}
public final class Attachment {}
public final class AttachmentBuilder {}
public final class MessagePayload {}

public final class Message {
    public init() {}
}

public final class MessageManager {}
public final class DMMessageManager: MessageManager {}
public final class GuildMessageManager: MessageManager {}
public final class PartialGroupDMMessageManager: MessageManager {}

public final class MessageMentions {}
public final class MessageReaction {}
public final class ReactionEmoji {}
public final class ReactionManager {}
public final class ReactionUserManager {}

public final class Typing {}

public final class BaseChannel: Base {}
public final class BaseGuild: Base {}
public final class Guild: BaseGuild {}
public final class AnonymousGuild: BaseGuild {}

public final class BaseGuildTextChannel: BaseChannel {}
public final class BaseGuildVoiceChannel: BaseChannel {}

public final class GuildChannel: BaseChannel {}
public final class GuildChannelManager {}
public final class ChannelManager {}
public final class CategoryChannel: GuildChannel {}
public final class DirectoryChannel: GuildChannel {}
public final class ForumChannel: GuildChannel {}
public final class NewsChannel: GuildChannel {}
public final class MediaChannel: GuildChannel {}
public final class TextChannel: GuildChannel {}
public final class VoiceChannel: GuildChannel {}
public final class StageChannel: GuildChannel {}
public final class ThreadChannel: GuildChannel {}
public final class ThreadOnlyChannel: GuildChannel {}
public final class DMChannel: BaseChannel {}
public final class PartialGroupDMChannel: BaseChannel {}

public final class CategoryChannelChildManager {}
public final class ThreadManager {}
public final class DMChannelManager {}

public final class Role {}
public final class RoleManager {}
public final class PermissionOverwrites {}
public final class PermissionOverwriteManager {}

public final class User {}
public final class UserManager {}
public final class OAuth2Guild {}

public final class Presence {}
public final class PresenceManager {}

public final class VoiceRegion {}
public final class VoiceState {}
public final class VoiceStateManager {}
public final class VoiceChannelEffect {}
public enum VoiceConnectionStates: String, Codable, Sendable { case disconnected, connecting, signaling, connected, reconnecting, destroyed }

public final class Shard {}
public final class ShardClientUtil {}
public final class ShardingManager {}
public final class SimpleIdentifyThrottler {}
public final class SimpleShardingStrategy {}
public final class WorkerBootstrapper {}
public final class WorkerContextFetchingStrategy {}
public final class WorkerShardingStrategy {}
public final class SimpleContextFetchingStrategy {}

public final class WebSocketManager {}
public final class WebSocketShard {}

public final class Webhook {}
public final class WebhookClient {}
public final class InteractionWebhook {}

public final class InteractionCollector: Collector {}
public final class MessageCollector: Collector {}
public final class ReactionCollector: Collector {}

public final class BaseGuildEmoji {}
public final class BaseGuildEmojiManager {}
public final class Emoji {}
public final class GuildEmoji: BaseGuildEmoji {}
public final class GuildEmojiManager {}
public final class GuildEmojiRoleManager {}
public final class ApplicationEmoji {}
public final class ApplicationEmojiManager {}

public final class Application {}
public final class ClientApplicationManager {}

public final class ApplicationCommand {}
public final class ApplicationCommandManager {}
public final class GuildApplicationCommandManager: ApplicationCommandManager {}
public final class ApplicationCommandPermissionsManager {}
public final class CommandInteractionOptionResolver {}

public final class ApplicationRoleConnectionMetadata {}

public final class ContextMenuCommandBuilder {}
public final class SlashCommandBuilder {}
public final class SlashCommandSubcommandBuilder {}
public final class SlashCommandSubcommandGroupBuilder {}
public final class SharedSlashCommand {}
public final class SharedSlashCommandOptions {}
public final class SharedSlashCommandSubcommands {}
public final class SharedNameAndDescription {}

public final class SlashCommandStringOption {}
public final class SlashCommandIntegerOption {}
public final class SlashCommandNumberOption {}
public final class SlashCommandBooleanOption {}
public final class SlashCommandUserOption {}
public final class SlashCommandChannelOption {}
public final class SlashCommandRoleOption {}
public final class SlashCommandMentionableOption {}
public final class SlashCommandAttachmentOption {}

public final class BaseGuildEmojiManagerCompat {}

public final class Invite {}
public final class InviteGuild {}
public final class InviteStageInstance {}

public final class Team {}
public final class TeamMember {}

public final class Sticker {}
public final class StickerPack {}
public final class GuildStickerManager {}

public final class GuildMember {}
public final class GuildMemberManager {}
public final class GuildMemberRoleManager {}

public final class GuildManager {}
public final class GuildBan {}
public final class GuildBanManager {}
public final class GuildAuditLogs {}
public final class GuildAuditLogsEntry {}
public final class GuildInviteManager {}
public final class GuildScheduledEvent {}
public final class GuildScheduledEventManager {}
public final class GuildTemplate {}
public final class GuildForumThreadManager {}
public final class GuildTextThreadManager {}
public final class GuildSoundboardSoundManager {}
public final class GuildOnboarding {}
public final class GuildOnboardingPrompt {}
public final class GuildOnboardingPromptOption {}
public final class GuildPreview {}
public final class GuildPreviewEmoji {}

public final class SoundboardSound {}
public final class SKU {}
public final class Subscription {}
public final class SubscriptionManager {}
public final class Entitlement {}
public final class EntitlementManager {}

public final class Sweepers {}

public final class Poll {}
public final class PollAnswer {}
public final class PollAnswerVoterManager {}

public final class AutoModerationRule {}
public final class AutoModerationRuleManager {}
public final class AutoModerationActionExecution {}

public final class InteractionCallback {}
public final class InteractionCallbackResource {}
public final class InteractionCallbackResponse {}
public final class InteractionResponse {}

public final class BaseInteractionResponse {}

public final class CommandInteraction: BaseInteraction {}
public final class ChatInputCommandInteraction: CommandInteraction {}
public final class PrimaryEntryPointCommandInteraction: CommandInteraction {}
public final class ContextMenuCommandInteraction: CommandInteraction {}
public final class UserContextMenuCommandInteraction: ContextMenuCommandInteraction {}
public final class MessageContextMenuCommandInteraction: ContextMenuCommandInteraction {}

public final class AutocompleteInteraction: BaseInteraction {}
public final class ButtonInteraction: BaseInteraction {}
public final class MessageComponentInteraction: BaseInteraction {}
public final class ModalSubmitInteraction: BaseInteraction {}
public final class ModalSubmitFields {}
public final class ChannelSelectMenuInteraction: BaseInteraction {}
public final class RoleSelectMenuInteraction: BaseInteraction {}
public final class UserSelectMenuInteraction: BaseInteraction {}
public final class MentionableSelectMenuInteraction: BaseInteraction {}
public final class StringSelectMenuInteraction: BaseInteraction {}

public final class StageInstance {}
public final class StageInstanceManager {}
public final class WelcomeScreen {}
public final class WelcomeChannel {}
public final class Widget {}
public final class WidgetMember {}

public final class Activity {}
public final class RichPresenceAssets {}

public enum ActivityType: Int, Codable, Sendable { case playing = 0, streaming = 1, listening = 2, watching = 3, custom = 4, competing = 5 }
public enum ActivityPlatform: String, Codable, Sendable { case desktop, mobile, web }
public enum ActivityFlags: Int, Codable, Sendable { case instance = 1 }

public enum ButtonStyle: Int, Codable, Sendable { case primary = 1, secondary = 2, success = 3, danger = 4, link = 5 }
public enum ChannelType: Int, Codable, Sendable { case guildText = 0, dm = 1, guildVoice = 2, groupDM = 3, guildCategory = 4 }
public enum ChannelFlags: Int, Codable, Sendable { case pinned = 1 }
public enum MessageFlags: Int, Codable, Sendable { case crossposted = 1 }
public enum InviteFlags: Int, Codable, Sendable { case guest = 1 }
public enum RoleFlags: Int, Codable, Sendable { case inPrompt = 1 }
public enum SKUFlags: Int, Codable, Sendable { case available = 1 }
public enum UserFlags: Int, Codable, Sendable { case staff = 1 }
public enum AttachmentFlags: Int, Codable, Sendable { case isRemix = 1 }

public enum ApplicationFlags: Int, Codable, Sendable { case gatewayPresence = 1 }
public enum ApplicationCommandType: Int, Codable, Sendable { case chatInput = 1, user = 2, message = 3 }
public enum ApplicationCommandOptionType: Int, Codable, Sendable { case subcommand = 1, subcommandGroup = 2, string = 3, integer = 4, boolean = 5, user = 6, channel = 7, role = 8, mentionable = 9, number = 10, attachment = 11 }
public enum ApplicationCommandPermissionType: Int, Codable, Sendable { case role = 1, user = 2, channel = 3 }

public enum AutoModerationActionType: Int, Codable, Sendable { case blockMessage = 1, sendAlertMessage = 2, timeout = 3 }
public enum AutoModerationRuleEventType: Int, Codable, Sendable { case messageSend = 1 }
public enum AutoModerationRuleKeywordPresetType: Int, Codable, Sendable { case profanity = 1, sexualContent = 2, slurs = 3 }
public enum AutoModerationRuleTriggerType: Int, Codable, Sendable { case keyword = 1, spam = 3, keywordPreset = 4, mentionSpam = 5 }

public enum CloseCodes: Int, Codable, Sendable { case unknownError = 4000 }
public enum GatewayCloseCodes: Int, Codable, Sendable { case unknownError = 4000 }
public enum GatewayDispatchEvents: String, Codable, Sendable { case ready = "READY", messageCreate = "MESSAGE_CREATE" }
public enum GatewayIntentBits: Int, Codable, Sendable { case guilds = 1 }
public enum GatewayOpcodes: Int, Codable, Sendable { case dispatch = 0, heartbeat = 1, identify = 2, resume = 6, reconnect = 7, invalidSession = 9, hello = 10, heartbeatACK = 11 }
public enum ShardEvents: String, Codable, Sendable { case ready, close, reconnecting }

public enum InteractionType: Int, Codable, Sendable { case ping = 1, applicationCommand = 2, messageComponent = 3, autocomplete = 4, modalSubmit = 5 }
public enum InteractionResponseType: Int, Codable, Sendable { case pong = 1, channelMessageWithSource = 4, deferredChannelMessageWithSource = 5, deferredMessageUpdate = 6, updateMessage = 7, modal = 9 }
public enum InteractionContextType: Int, Codable, Sendable { case guild = 0, botDM = 1, privateChannel = 2 }

public enum AllowedMentionsTypes: String, Codable, Sendable { case roles, users, everyone }
public enum EmbedType: String, Codable, Sendable { case rich, image, video, gifv, article, link }
public enum Encoding: String, Codable, Sendable { case json, etf }
public enum CompressionMethod: String, Codable, Sendable { case zlibStream = "zlib-stream" }
public enum Events: String, Codable, Sendable { case messageCreate = "messageCreate", ready = "ready" }
public enum RequestMethod: String, Codable, Sendable { case get, post, put, patch, delete }
public enum RESTEvents: String, Codable, Sendable { case rateLimited }
public enum RESTJSONErrorCodes: Int, Codable, Sendable { case unknown = 0 }
public enum DiscordjsErrorCodes: String, Codable, Sendable { case unknown }

public enum GuildMemberFlags: Int, Codable, Sendable { case didRejoin = 1 }
public enum ThreadMemberFlags: Int, Codable, Sendable { case hasInteracted = 1 }
public enum SystemChannelFlags: Int, Codable, Sendable { case suppressJoinNotifications = 1 }
public enum GuildExplicitContentFilter: Int, Codable, Sendable { case disabled = 0, membersWithoutRoles = 1, allMembers = 2 }
public enum GuildDefaultMessageNotifications: Int, Codable, Sendable { case allMessages = 0, onlyMentions = 1 }
public enum GuildMFALevel: Int, Codable, Sendable { case none = 0, elevated = 1 }
public enum GuildVerificationLevel: Int, Codable, Sendable { case none = 0, low = 1, medium = 2, high = 3, veryHigh = 4 }
public enum GuildNSFWLevel: Int, Codable, Sendable { case `default` = 0, explicit = 1, safe = 2, ageRestricted = 3 }
public enum GuildPremiumTier: Int, Codable, Sendable { case none = 0, tier1 = 1, tier2 = 2, tier3 = 3 }
public enum GuildScheduledEventStatus: Int, Codable, Sendable { case scheduled = 1, active = 2, completed = 3, canceled = 4 }
public enum GuildScheduledEventPrivacyLevel: Int, Codable, Sendable { case guildOnly = 2 }
public enum GuildScheduledEventEntityType: Int, Codable, Sendable { case stageInstance = 1, voice = 2, external = 3 }
public enum StageInstancePrivacyLevel: Int, Codable, Sendable { case publicStage = 1, guildOnly = 2 }
public enum VideoQualityMode: Int, Codable, Sendable { case auto = 1, full = 2 }
public enum TextInputStyle: Int, Codable, Sendable { case short = 1, paragraph = 2 }
public enum ForumLayoutType: Int, Codable, Sendable { case notSet = 0, listView = 1, galleryView = 2 }
public enum ThreadAutoArchiveDuration: Int, Codable, Sendable { case oneHour = 60, oneDay = 1440, threeDays = 4320, oneWeek = 10080 }

public enum Locale: String, Codable, Sendable { case enUS = "en-US" }
public enum OAuth2Scopes: String, Codable, Sendable { case identify, guilds, bot, applicationsCommands = "applications.commands" }

public enum ImageFormat: String, Codable, Sendable { case png, jpg, webp, gif }
public enum HeadingLevel: Int, Codable, Sendable { case one = 1, two = 2, three = 3, four = 4, five = 5, six = 6 }

public enum Status: String, Codable, Sendable { case online, idle, dnd, invisible, offline }
public enum PresenceUpdateStatus: String, Codable, Sendable { case online, idle, dnd, invisible, offline }
public enum SortOrderType: Int, Codable, Sendable { case latestActivity = 0, creationDate = 1 }
public enum SeparatorSpacingSize: Int, Codable, Sendable { case small = 1, medium = 2, large = 3 }
public enum SelectMenuDefaultValueType: String, Codable, Sendable { case user, role, channel }
public enum RelationshipType: Int, Codable, Sendable { case none = 0 }
public enum ReactionType: Int, Codable, Sendable { case normal = 0, burst = 1 }
public enum InviteTargetType: Int, Codable, Sendable { case stream = 1, embeddedApplication = 2 }
public enum InviteType: Int, Codable, Sendable { case guild = 0 }
public enum OverwriteType: Int, Codable, Sendable { case role = 0, member = 1 }
public enum Partials: String, Codable, Sendable { case user, channel, guildMember = "guildMember", message, reaction }
public enum PollLayoutType: Int, Codable, Sendable { case `default` = 1 }
public enum MessageType: Int, Codable, Sendable { case `default` = 0 }
public enum MessageReferenceType: Int, Codable, Sendable { case reply = 0 }
public enum MessageActivityType: Int, Codable, Sendable { case join = 1 }
public enum StickerType: Int, Codable, Sendable { case standard = 1, guild = 2 }
public enum StickerFormatType: Int, Codable, Sendable { case png = 1, apng = 2, lottie = 3, gif = 4 }
public enum StatusDisplayType: Int, Codable, Sendable { case compact = 0, expanded = 1 }
public enum NameplatePalette: Int, Codable, Sendable { case `default` = 0 }
public enum Faces: String, Codable, Sendable { case shrug = "¯\\_(ツ)_/¯" }

public enum SubscriptionStatus: Int, Codable, Sendable { case active = 0 }
public enum EntitlementOwnerType: Int, Codable, Sendable { case guild = 1, user = 2 }
public enum EntitlementType: Int, Codable, Sendable { case purchase = 1 }
public enum SKUType: Int, Codable, Sendable { case durable = 2, consumable = 3, subscription = 5, subscriptionGroup = 6 }

public enum WebhookType: Int, Codable, Sendable { case incoming = 1, channelFollower = 2, application = 3 }

public enum ConnectionService: String, Codable, Sendable { case unknown }
public enum ConnectionVisibility: Int, Codable, Sendable { case none = 0, everyone = 1 }

public enum WorkerReceivePayloadOp: Int, Codable, Sendable { case dispatch = 0 }
public enum WorkerSendPayloadOp: Int, Codable, Sendable { case dispatch = 0 }
public enum WebSocketShardEvents: String, Codable, Sendable { case ready, resumed, close }
public enum WebSocketShardStatus: String, Codable, Sendable { case idle, connecting, ready, resuming, disconnected }
public enum WebSocketShardDestroyRecovery: String, Codable, Sendable { case reconnect, resume }

public enum ApplicationIntegrationType: Int, Codable, Sendable { case guildInstall = 0, userInstall = 1 }
public enum ApplicationRoleConnectionMetadataType: Int, Codable, Sendable { case integerLessThanOrEqual = 1 }
public enum ApplicationWebhookEventStatus: Int, Codable, Sendable { case scheduled = 0 }
public enum ApplicationWebhookEventType: Int, Codable, Sendable { case applicationAuthorized = 1 }
public enum ApplicationWebhookType: Int, Codable, Sendable { case ping = 1 }
public enum EntryPointCommandHandlerType: Int, Codable, Sendable { case app = 0 }
public enum GuildFeature: String, Codable, Sendable { case animatedBanner = "ANIMATED_BANNER" }
public enum GuildHubType: Int, Codable, Sendable { case `default` = 0 }
public enum GuildNavigationMentions: Int, Codable, Sendable { case all = 0 }
public enum GuildOnboardingMode: Int, Codable, Sendable { case `default` = 0 }
public enum GuildOnboardingPromptType: Int, Codable, Sendable { case multipleChoice = 0 }
public enum GuildScheduledEventRecurrenceRuleFrequency: Int, Codable, Sendable { case yearly = 0 }
public enum GuildScheduledEventRecurrenceRuleMonth: Int, Codable, Sendable { case january = 1 }
public enum GuildScheduledEventRecurrenceRuleWeekday: Int, Codable, Sendable { case monday = 0 }
public enum GuildSystemChannelFlags: Int, Codable, Sendable { case suppressJoinNotifications = 1 }
public enum GuildWidgetStyle: String, Codable, Sendable { case shield, banner1, banner2, banner3, banner4 }
public enum IntegrationExpireBehavior: Int, Codable, Sendable { case removeRole = 0, kick = 1 }
public enum MembershipScreeningFieldType: Int, Codable, Sendable { case terms = 0 }
public enum RPCCommands: String, Codable, Sendable { case authenticate = "AUTHENTICATE" }
public enum RPCCloseEventCodes: Int, Codable, Sendable { case closeNormal = 1000 }
public enum RPCDeviceType: String, Codable, Sendable { case microphone, speaker, headset }
public enum RPCErrorCodes: Int, Codable, Sendable { case unknown = 0 }
public enum RPCEvents: String, Codable, Sendable { case ready = "READY" }
public enum RPCVoiceSettingsModeType: String, Codable, Sendable { case pushToTalk = "PUSH_TO_TALK" }
public enum RPCVoiceShortcutKeyComboKeyType: Int, Codable, Sendable { case keyboard = 0 }
public enum TeamMemberMembershipState: Int, Codable, Sendable { case invited = 1, accepted = 2 }
public enum TeamMemberRole: String, Codable, Sendable { case owner, admin, developer, readOnly = "read_only" }
public enum UnfurledMediaItemLoadingState: Int, Codable, Sendable { case unknown = 0 }
public enum UserPremiumType: Int, Codable, Sendable { case none = 0, nitroClassic = 1, nitro = 2, nitroBasic = 3 }
public enum VoiceChannelEffectSendAnimationType: Int, Codable, Sendable { case normal = 0 }
public enum GatewayOpcodesCompat: Int, Codable, Sendable { case dispatch = 0 }

public enum AllowedMentionsTypesCompat: String, Codable, Sendable { case users, roles, everyone }

public func applicationDirectory() -> URL { URL(fileURLWithPath: FileManager.default.currentDirectoryPath) }
public func bold(_ input: String) -> String { "**\(input)**" }
public func italic(_ input: String) -> String { "*\(input)*" }
public func underline(_ input: String) -> String { "__\(input)__" }
public func strikethrough(_ input: String) -> String { "~~\(input)~~" }
public func spoiler(_ input: String) -> String { "||\(input)||" }
public func inlineCode(_ input: String) -> String { "`\(input)`" }
public func codeBlock(_ language: String? = nil, _ input: String) -> String {
    if let language, !language.isEmpty { return "```\(language)\n\(input)\n```" }
    return "```\n\(input)\n```"
}
public func quote(_ input: String) -> String { "> \(input)" }
public func blockQuote(_ input: String) -> String { input.split(separator: "\n").map { "> \($0)" }.joined(separator: "\n") }
public func heading(_ level: HeadingLevel, _ input: String) -> String { String(repeating: "#", count: level.rawValue) + " " + input }
public func orderedList(_ items: [String]) -> String { items.enumerated().map { "\($0.offset + 1). \($0.element)" }.joined(separator: "\n") }
public func unorderedList(_ items: [String]) -> String { items.map { "- \($0)" }.joined(separator: "\n") }
public func hyperlink(_ text: String, _ url: String) -> String { "[\(text)](\(url))" }
public func hideLinkEmbed(_ url: String) -> String { "<\(url)>" }
public func userMention(_ id: String) -> String { "<@\(id)>" }
public func channelMention(_ id: String) -> String { "<#\(id)>" }
public func roleMention(_ id: String) -> String { "<@&\(id)>" }
public func messageLink(guildID: String, channelID: String, messageID: String) -> String { "https://discord.com/channels/\(guildID)/\(channelID)/\(messageID)" }
public func channelLink(guildID: String, channelID: String) -> String { "https://discord.com/channels/\(guildID)/\(channelID)" }
public func time(_ unixSeconds: Int, style: String? = nil) -> String { style.map { "<t:\(unixSeconds):\($0)>" } ?? "<t:\(unixSeconds)>" }
public func escapeMarkdown(_ input: String) -> String {
    var s = input
    let replacements: [(String, String)] = [
        ("\\", "\\\\"),
        ("*", "\\*"),
        ("_", "\\_"),
        ("~", "\\~"),
        ("`", "\\`"),
        ("|", "\\|"),
        (">", "\\>"),
        ("[", "\\["),
        ("]", "\\]"),
        ("(", "\\("),
        (")", "\\)")
    ]
    for (a, b) in replacements { s = s.replacingOccurrences(of: a, with: b) }
    return s
}
public func escapeBold(_ input: String) -> String { input.replacingOccurrences(of: "*", with: "\\*") }
public func escapeItalic(_ input: String) -> String { input.replacingOccurrences(of: "*", with: "\\*") }
public func escapeUnderline(_ input: String) -> String { input.replacingOccurrences(of: "_", with: "\\_") }
public func escapeStrikethrough(_ input: String) -> String { input.replacingOccurrences(of: "~", with: "\\~") }
public func escapeSpoiler(_ input: String) -> String { input.replacingOccurrences(of: "|", with: "\\|") }
public func escapeInlineCode(_ input: String) -> String { input.replacingOccurrences(of: "`", with: "\\`") }
public func escapeCodeBlock(_ input: String) -> String { input.replacingOccurrences(of: "```", with: "\\`\\`\\`") }
public func escapeHeading(_ input: String) -> String { input.replacingOccurrences(of: "#", with: "\\#") }
public func escapeNumberedList(_ input: String) -> String { input.replacingOccurrences(of: ".", with: "\\.") }
public func escapeBulletedList(_ input: String) -> String { input.replacingOccurrences(of: "-", with: "\\-") }
public func escapeMaskedLink(_ input: String) -> String { input.replacingOccurrences(of: "](", with: "\\]\\(") }
public func escapeEscape(_ input: String) -> String { input.replacingOccurrences(of: "\\", with: "\\\\") }

public func verifyString(_ input: Any?) -> String? { input as? String }
public func isEquatable<T>(_ value: T) -> Bool { (value as Any) is any Equatable }
public func isJSONEncodable<T>(_ value: T) -> Bool { true }
public func parseWebhookURL(_ url: String) -> (id: String, token: String)? {
    let parts = url.split(separator: "/").map(String.init)
    guard let id = parts.last, parts.count >= 2 else { return nil }
    let token = parts.dropLast().last ?? ""
    return (id, token)
}
public func parseEmoji(_ input: String) -> (name: String?, id: String?, animated: Bool) {
    let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
    if trimmed.hasPrefix("<a:"), trimmed.hasSuffix(">") {
        let inner = trimmed.dropFirst(3).dropLast()
        let parts = inner.split(separator: ":").map(String.init)
        return (parts.first, parts.count > 1 ? parts[1] : nil, true)
    }
    if trimmed.hasPrefix("<:"), trimmed.hasSuffix(">") {
        let inner = trimmed.dropFirst(2).dropLast()
        let parts = inner.split(separator: ":").map(String.init)
        return (parts.first, parts.count > 1 ? parts[1] : nil, false)
    }
    return (trimmed, nil, false)
}
public func formatEmoji(name: String, id: String? = nil, animated: Bool = false) -> String {
    if let id { return animated ? "<a:\(name):\(id)>" : "<:\(name):\(id)>" }
    return name
}
public func flatten<T>(_ items: [[T]]) -> [T] { items.flatMap { $0 } }
public func normalizeArray<T>(_ value: T) -> [T] { [value] }
public func range(_ start: Int, _ end: Int) -> [Int] { Array(start...end) }
public func discordSort<T: Comparable>(_ items: [T]) -> [T] { items.sorted() }
public func calculateShardId(guildID: String, shardCount: Int) -> Int {
    guard let snowflake = UInt64(guildID) else { return 0 }
    let shifted = (snowflake >> 22)
    return Int(shifted % UInt64(max(1, shardCount)))
}
public func calculateUserDefaultAvatarIndex(discriminator: Int) -> Int { abs(discriminator) % 5 }
public func embedLength(_ text: String) -> Int { text.count }
public func cleanCodeBlockContent(_ text: String) -> String { text.replacingOccurrences(of: "```", with: "") }
public func cleanContent(_ text: String) -> String { text.trimmingCharacters(in: .whitespacesAndNewlines) }
public func lazy<T>(_ value: @autoclosure () -> T) -> T { value() }
public func phoneNumber(_ text: String) -> String { text }
public func email(_ text: String) -> String { text }
public func subtext(_ text: String) -> String { "-# \(text)" }
public func underscore(_ text: String) -> String { "_\(text)_" }
public func linkedRoleMention(_ id: String) -> String { "<@&\(id)>" }
public func chatInputApplicationCommandMention(_ name: String, _ id: String) -> String { "</\(name):\(id)>" }
public func makeURLSearchParams(_ items: [String: String]) -> String {
    items.map { key, value in "\(key)=\(value)" }.joined(separator: "&")
}
public func parseResponse(_ data: Data) -> String { String(data: data, encoding: .utf8) ?? "" }
public func polyfillDispose() {}
public func resolveColor(_ input: String) -> Int { Int(input.trimmingCharacters(in: CharacterSet(charactersIn: "#")), radix: 16) ?? 0 }
public func resolveSKUId(_ input: String) -> String { input }
public func shouldUseGlobalFetchAndWebSocket() -> Bool { true }
public func getUserAgentAppendix() -> String { "ProjectSwift" }
public func getInitialSendRateLimitState() -> Int { 0 }
public func managerToFetchingStrategyOptions() -> [String: String] { [:] }
public func resolveBuilder<T>(_ value: T) -> T { value }
public func createComponentBuilder() -> ComponentBuilder { ComponentBuilder() }
public func enableValidators() {}
public func disableValidators() {}
public func isValidationEnabled() -> Bool { true }
