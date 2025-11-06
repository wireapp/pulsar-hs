{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE DeriveTraversable          #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE RecordWildCards            #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE TypeOperators              #-}

module Pulsar.Admin.API
  ( -- * Client
    bookiesDeleteBookieRackInfo
  ,     bookiesGetAllBookies
  ,     bookiesGetBookieRackInfo
  ,     bookiesGetBookiesRackInfo
  ,     bookiesUpdateBookieRackInfo
  ,     brokerStatsBaseGetAllocatorStats
  ,     brokerStatsBaseGetLoadReport
  ,     brokerStatsBaseGetMBeans
  ,     brokerStatsBaseGetMetrics
  ,     brokerStatsBaseGetPendingBookieOpsStats
  ,     brokerStatsGetBrokerResourceAvailability
  ,     brokerStatsGetTopics2
  ,     brokersBaseBacklogQuotaCheck
  ,     brokersBaseDeleteDynamicConfiguration
  ,     brokersBaseGetActiveBrokers
  ,     brokersBaseGetActiveBrokersByCluster
  ,     brokersBaseGetAllDynamicConfigurations
  ,     brokersBaseGetDynamicConfigurationName
  ,     brokersBaseGetInternalConfigurationData
  ,     brokersBaseGetLeaderBroker
  ,     brokersBaseGetOwnedNamespaces
  ,     brokersBaseGetRuntimeConfiguration
  ,     brokersBaseHealthCheck
  ,     brokersBaseIsReady
  ,     brokersBaseShutDownBrokerGracefully
  ,     brokersBaseUpdateDynamicConfiguration
  ,     brokersBaseVersion
  ,     clustersBaseCreateCluster
  ,     clustersBaseDeleteCluster
  ,     clustersBaseDeleteFailureDomain
  ,     clustersBaseDeleteNamespaceIsolationPolicy
  ,     clustersBaseGetBrokerWithNamespaceIsolationPolicy
  ,     clustersBaseGetBrokersWithNamespaceIsolationPolicy
  ,     clustersBaseGetCluster
  ,     clustersBaseGetClusterMigration
  ,     clustersBaseGetClusters
  ,     clustersBaseGetDomain
  ,     clustersBaseGetFailureDomains
  ,     clustersBaseGetNamespaceIsolationPolicies
  ,     clustersBaseGetNamespaceIsolationPolicy
  ,     clustersBaseGetPeerCluster
  ,     clustersBaseSetFailureDomain
  ,     clustersBaseSetNamespaceIsolationPolicy
  ,     clustersBaseSetPeerClusterNames
  ,     clustersBaseUpdateCluster
  ,     clustersBaseUpdateClusterMigration
  ,     workerDrain
  ,     workerDrainAtLeader
  ,     workerGetAssignments
  ,     workerGetCluster
  ,     workerGetClusterLeader
  ,     workerGetConnectorsList
  ,     workerGetDrainStatus
  ,     workerGetDrainStatusFromLeader
  ,     workerIsLeaderReady
  ,     workerRebalance
  ,     workerStatsGetMetrics
  ,     workerStatsGetStats
  ,     namespacesClearNamespaceBacklog
  ,     namespacesClearNamespaceBacklogForSubscription
  ,     namespacesClearNamespaceBundleBacklog
  ,     namespacesClearNamespaceBundleBacklogForSubscription
  ,     namespacesClearOffloadDeletionLag
  ,     namespacesClearProperties
  ,     namespacesCreateNamespace
  ,     namespacesDeleteBookieAffinityGroup
  ,     namespacesDeleteCompactionThreshold
  ,     namespacesDeleteDispatchRate
  ,     namespacesDeleteNamespace
  ,     namespacesDeleteNamespaceBundle
  ,     namespacesDeletePersistence
  ,     namespacesDeleteSubscribeRate
  ,     namespacesDeleteSubscriptionDispatchRate
  ,     namespacesGetAntiAffinityNamespaces
  ,     namespacesGetAutoSubscriptionCreation
  ,     namespacesGetAutoTopicCreation
  ,     namespacesGetBacklogQuotaMap
  ,     namespacesGetBookieAffinityGroup
  ,     namespacesGetBundlesData
  ,     namespacesGetCompactionThreshold
  ,     namespacesGetDeduplication
  ,     namespacesGetDeduplicationSnapshotInterval
  ,     namespacesGetDelayedDeliveryPolicies
  ,     namespacesGetDispatchRate
  ,     namespacesGetDispatcherPauseOnAckStatePersistent
  ,     namespacesGetEncryptionRequired
  ,     namespacesGetEntryFiltersPerTopic
  ,     namespacesGetInactiveTopicPolicies
  ,     namespacesGetIsAllowAutoUpdateSchema
  ,     namespacesGetMaxConsumersPerSubscription
  ,     namespacesGetMaxConsumersPerTopic
  ,     namespacesGetMaxProducersPerTopic
  ,     namespacesGetMaxSubscriptionsPerTopic
  ,     namespacesGetMaxTopicsPerNamespace
  ,     namespacesGetMaxUnackedMessagesPerConsumer
  ,     namespacesGetMaxUnackedmessagesPerSubscription
  ,     namespacesGetNamespaceAllowedClusters
  ,     namespacesGetNamespaceAntiAffinityGroup
  ,     namespacesGetNamespaceMessageTTL
  ,     namespacesGetNamespaceReplicationClusters
  ,     namespacesGetNamespaceResourceGroup
  ,     namespacesGetOffloadDeletionLag
  ,     namespacesGetOffloadPolicies
  ,     namespacesGetOffloadThreshold
  ,     namespacesGetOffloadThresholdInSeconds
  ,     namespacesGetPermissionOnSubscription
  ,     namespacesGetPermissions
  ,     namespacesGetPersistence
  ,     namespacesGetPolicies
  ,     namespacesGetProperties
  ,     namespacesGetProperty
  ,     namespacesGetReplicatorDispatchRate
  ,     namespacesGetRetention
  ,     namespacesGetSchemaAutoUpdateCompatibilityStrategy
  ,     namespacesGetSchemaCompatibilityStrategy
  ,     namespacesGetSchemaValidtionEnforced
  ,     namespacesGetSubscribeRate
  ,     namespacesGetSubscriptionAuthMode
  ,     namespacesGetSubscriptionDispatchRate
  ,     namespacesGetSubscriptionExpirationTime
  ,     namespacesGetSubscriptionTypesEnabled
  ,     namespacesGetTenantNamespaces
  ,     namespacesGetTopicHashPositions
  ,     namespacesGetTopics
  ,     namespacesGrantPermissionOnNamespace
  ,     namespacesGrantPermissionsOnTopics
  ,     namespacesModifyDeduplication
  ,     namespacesModifyEncryptionRequired
  ,     namespacesRemoveAutoSubscriptionCreation
  ,     namespacesRemoveAutoTopicCreation
  ,     namespacesRemoveBacklogQuota
  ,     namespacesRemoveDeduplication
  ,     namespacesRemoveDelayedDeliveryPolicies
  ,     namespacesRemoveDispatcherPauseOnAckStatePersistent
  ,     namespacesRemoveInactiveTopicPolicies
  ,     namespacesRemoveMaxConsumersPerSubscription
  ,     namespacesRemoveMaxConsumersPerTopic
  ,     namespacesRemoveMaxProducersPerTopic
  ,     namespacesRemoveMaxSubscriptionsPerTopic
  ,     namespacesRemoveMaxTopicsPerNamespace
  ,     namespacesRemoveMaxUnackedmessagesPerConsumer
  ,     namespacesRemoveMaxUnackedmessagesPerSubscription
  ,     namespacesRemoveNamespaceAntiAffinityGroup
  ,     namespacesRemoveNamespaceEntryFilters
  ,     namespacesRemoveNamespaceMessageTTL
  ,     namespacesRemoveNamespaceResourceGroup
  ,     namespacesRemoveOffloadPolicies
  ,     namespacesRemoveProperty
  ,     namespacesRemoveReplicatorDispatchRate
  ,     namespacesRemoveRetention
  ,     namespacesRemoveSubscriptionExpirationTime
  ,     namespacesRemoveSubscriptionTypesEnabled
  ,     namespacesRevokePermissionsOnNamespace
  ,     namespacesRevokePermissionsOnTopics
  ,     namespacesScanOffloadedLedgers
  ,     namespacesSetAutoSubscriptionCreation
  ,     namespacesSetAutoTopicCreation
  ,     namespacesSetBacklogQuota
  ,     namespacesSetBookieAffinityGroup
  ,     namespacesSetCompactionThreshold
  ,     namespacesSetDeduplicationSnapshotInterval
  ,     namespacesSetDelayedDeliveryPolicies
  ,     namespacesSetDispatchRate
  ,     namespacesSetDispatcherPauseOnAckStatePersistent
  ,     namespacesSetEntryFiltersPerTopic
  ,     namespacesSetInactiveTopicPolicies
  ,     namespacesSetIsAllowAutoUpdateSchema
  ,     namespacesSetMaxConsumersPerSubscription
  ,     namespacesSetMaxConsumersPerTopic
  ,     namespacesSetMaxProducersPerTopic
  ,     namespacesSetMaxSubscriptionsPerTopic
  ,     namespacesSetMaxTopicsPerNamespace
  ,     namespacesSetMaxUnackedMessagesPerConsumer
  ,     namespacesSetMaxUnackedMessagesPerSubscription
  ,     namespacesSetNamespaceAllowedClusters
  ,     namespacesSetNamespaceAntiAffinityGroup
  ,     namespacesSetNamespaceMessageTTL
  ,     namespacesSetNamespaceReplicationClusters
  ,     namespacesSetNamespaceResourceGroup
  ,     namespacesSetOffloadDeletionLag
  ,     namespacesSetOffloadPolicies
  ,     namespacesSetOffloadThreshold
  ,     namespacesSetOffloadThresholdInSeconds
  ,     namespacesSetPersistence
  ,     namespacesSetProperties
  ,     namespacesSetProperty
  ,     namespacesSetReplicatorDispatchRate
  ,     namespacesSetRetention
  ,     namespacesSetSchemaAutoUpdateCompatibilityStrategy
  ,     namespacesSetSchemaCompatibilityStrategy
  ,     namespacesSetSchemaValidationEnforced
  ,     namespacesSetSubscribeRate
  ,     namespacesSetSubscriptionAuthMode
  ,     namespacesSetSubscriptionDispatchRate
  ,     namespacesSetSubscriptionExpirationTime
  ,     namespacesSetSubscriptionTypesEnabled
  ,     namespacesSplitNamespaceBundle
  ,     namespacesUnloadNamespace
  ,     namespacesUnloadNamespaceBundle
  ,     namespacesUnsubscribeNamespace
  ,     namespacesUnsubscribeNamespaceBundle
  ,     nonPersistentTopicsAnalyzeSubscriptionBacklog
  ,     nonPersistentTopicsCompact
  ,     nonPersistentTopicsCompactionStatus
  ,     nonPersistentTopicsCreateMissedPartitions
  ,     nonPersistentTopicsCreateNonPartitionedTopic
  ,     nonPersistentTopicsCreatePartitionedTopic
  ,     nonPersistentTopicsCreateSubscription
  ,     nonPersistentTopicsDeleteDeduplicationSnapshotInterval
  ,     nonPersistentTopicsDeleteDelayedDeliveryPolicies
  ,     nonPersistentTopicsDeleteInactiveTopicPolicies
  ,     nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumer
  ,     nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscription
  ,     nonPersistentTopicsDeletePartitionedTopic
  ,     nonPersistentTopicsDeleteShadowTopics
  ,     nonPersistentTopicsDeleteSubscription
  ,     nonPersistentTopicsDeleteTopic
  ,     nonPersistentTopicsDeleteTopicPolicies
  ,     nonPersistentTopicsExamineMessage
  ,     nonPersistentTopicsExpireMessagesForAllSubscriptions
  ,     nonPersistentTopicsGetAutoSubscriptionCreation
  ,     nonPersistentTopicsGetBacklog
  ,     nonPersistentTopicsGetBacklogQuotaMap
  ,     nonPersistentTopicsGetBacklogSizeByMessageId
  ,     nonPersistentTopicsGetCompactionThreshold
  ,     nonPersistentTopicsGetDeduplication
  ,     nonPersistentTopicsGetDeduplicationSnapshotInterval
  ,     nonPersistentTopicsGetDelayedDeliveryPolicies
  ,     nonPersistentTopicsGetDispatchRate
  ,     nonPersistentTopicsGetDispatcherPauseOnAckStatePersistent
  ,     nonPersistentTopicsGetEntryFilters
  ,     nonPersistentTopicsGetExpireTopicMessages
  ,     nonPersistentTopicsGetInactiveTopicPolicies
  ,     nonPersistentTopicsGetInternalStats
  ,     nonPersistentTopicsGetLastMessageId
  ,     nonPersistentTopicsGetList
  ,     nonPersistentTopicsGetListFromBundle
  ,     nonPersistentTopicsGetManagedLedgerInfo
  ,     nonPersistentTopicsGetMaxConsumers
  ,     nonPersistentTopicsGetMaxConsumersPerSubscription
  ,     nonPersistentTopicsGetMaxMessageSize
  ,     nonPersistentTopicsGetMaxProducers
  ,     nonPersistentTopicsGetMaxSubscriptionsPerTopic
  ,     nonPersistentTopicsGetMaxUnackedMessagesOnConsumer
  ,     nonPersistentTopicsGetMaxUnackedMessagesOnSubscription
  ,     nonPersistentTopicsGetMessageById
  ,     nonPersistentTopicsGetMessageIdByTimestamp
  ,     nonPersistentTopicsGetMessageTTL
  ,     nonPersistentTopicsGetOffloadPolicies
  ,     nonPersistentTopicsGetPartitionedMetadata
  ,     nonPersistentTopicsGetPartitionedStats
  ,     nonPersistentTopicsGetPartitionedStatsInternal
  ,     nonPersistentTopicsGetPartitionedTopicList
  ,     nonPersistentTopicsGetPermissionsOnTopic
  ,     nonPersistentTopicsGetPersistence
  ,     nonPersistentTopicsGetProperties
  ,     nonPersistentTopicsGetPublishRate
  ,     nonPersistentTopicsGetReplicatedSubscriptionStatus
  ,     nonPersistentTopicsGetReplicationClusters
  ,     nonPersistentTopicsGetReplicatorDispatchRate
  ,     nonPersistentTopicsGetRetention
  ,     nonPersistentTopicsGetSchemaCompatibilityStrategy
  ,     nonPersistentTopicsGetSchemaValidationEnforced
  ,     nonPersistentTopicsGetShadowTopics
  ,     nonPersistentTopicsGetStats
  ,     nonPersistentTopicsGetSubscribeRate
  ,     nonPersistentTopicsGetSubscriptionDispatchRate
  ,     nonPersistentTopicsGetSubscriptionLevelDispatchRate
  ,     nonPersistentTopicsGetSubscriptionProperties
  ,     nonPersistentTopicsGetSubscriptionTypesEnabled
  ,     nonPersistentTopicsGetSubscriptions
  ,     nonPersistentTopicsGrantPermissionsOnTopic
  ,     nonPersistentTopicsOffloadStatus
  ,     nonPersistentTopicsPeekNthMessage
  ,     nonPersistentTopicsPostExpireTopicMessages
  ,     nonPersistentTopicsRemoveAutoSubscriptionCreation
  ,     nonPersistentTopicsRemoveBacklogQuota
  ,     nonPersistentTopicsRemoveCompactionThreshold
  ,     nonPersistentTopicsRemoveDeduplication
  ,     nonPersistentTopicsRemoveDispatchRate
  ,     nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistent
  ,     nonPersistentTopicsRemoveEntryFilters
  ,     nonPersistentTopicsRemoveMaxConsumers
  ,     nonPersistentTopicsRemoveMaxConsumersPerSubscription
  ,     nonPersistentTopicsRemoveMaxMessageSize
  ,     nonPersistentTopicsRemoveMaxProducers
  ,     nonPersistentTopicsRemoveMaxSubscriptionsPerTopic
  ,     nonPersistentTopicsRemoveMessageTTL
  ,     nonPersistentTopicsRemoveOffloadPolicies
  ,     nonPersistentTopicsRemovePersistence
  ,     nonPersistentTopicsRemoveProperties
  ,     nonPersistentTopicsRemovePublishRate
  ,     nonPersistentTopicsRemoveReplicationClusters
  ,     nonPersistentTopicsRemoveReplicatorDispatchRate
  ,     nonPersistentTopicsRemoveRetention
  ,     nonPersistentTopicsRemoveSchemaCompatibilityStrategy
  ,     nonPersistentTopicsRemoveSubscribeRate
  ,     nonPersistentTopicsRemoveSubscriptionDispatchRate
  ,     nonPersistentTopicsRemoveSubscriptionLevelDispatchRate
  ,     nonPersistentTopicsRemoveSubscriptionTypesEnabled
  ,     nonPersistentTopicsResetCursor
  ,     nonPersistentTopicsResetCursorOnPosition
  ,     nonPersistentTopicsRevokePermissionsOnTopic
  ,     nonPersistentTopicsSetAutoSubscriptionCreation
  ,     nonPersistentTopicsSetBacklogQuota
  ,     nonPersistentTopicsSetCompactionThreshold
  ,     nonPersistentTopicsSetDeduplication
  ,     nonPersistentTopicsSetDeduplicationSnapshotInterval
  ,     nonPersistentTopicsSetDelayedDeliveryPolicies
  ,     nonPersistentTopicsSetDispatchRate
  ,     nonPersistentTopicsSetDispatcherPauseOnAckStatePersistent
  ,     nonPersistentTopicsSetEntryFilters
  ,     nonPersistentTopicsSetInactiveTopicPolicies
  ,     nonPersistentTopicsSetMaxConsumers
  ,     nonPersistentTopicsSetMaxConsumersPerSubscription
  ,     nonPersistentTopicsSetMaxMessageSize
  ,     nonPersistentTopicsSetMaxProducers
  ,     nonPersistentTopicsSetMaxSubscriptionsPerTopic
  ,     nonPersistentTopicsSetMaxUnackedMessagesOnConsumer
  ,     nonPersistentTopicsSetMaxUnackedMessagesOnSubscription
  ,     nonPersistentTopicsSetMessageTTL
  ,     nonPersistentTopicsSetOffloadPolicies
  ,     nonPersistentTopicsSetPersistence
  ,     nonPersistentTopicsSetPublishRate
  ,     nonPersistentTopicsSetReplicatedSubscriptionStatus
  ,     nonPersistentTopicsSetReplicationClusters
  ,     nonPersistentTopicsSetReplicatorDispatchRate
  ,     nonPersistentTopicsSetRetention
  ,     nonPersistentTopicsSetSchemaCompatibilityStrategy
  ,     nonPersistentTopicsSetSchemaValidationEnforced
  ,     nonPersistentTopicsSetShadowTopics
  ,     nonPersistentTopicsSetSubscribeRate
  ,     nonPersistentTopicsSetSubscriptionDispatchRate
  ,     nonPersistentTopicsSetSubscriptionLevelDispatchRate
  ,     nonPersistentTopicsSetSubscriptionTypesEnabled
  ,     nonPersistentTopicsSkipAllMessages
  ,     nonPersistentTopicsSkipMessages
  ,     nonPersistentTopicsTerminate
  ,     nonPersistentTopicsTerminatePartitionedTopic
  ,     nonPersistentTopicsTriggerOffload
  ,     nonPersistentTopicsTrimTopic
  ,     nonPersistentTopicsTruncateTopic
  ,     nonPersistentTopicsUnloadTopic
  ,     nonPersistentTopicsUpdatePartitionedTopic
  ,     nonPersistentTopicsUpdateProperties
  ,     nonPersistentTopicsUpdateSubscriptionProperties
  ,     persistentTopicsAnalyzeSubscriptionBacklog
  ,     persistentTopicsCompact
  ,     persistentTopicsCompactionStatus
  ,     persistentTopicsCreateMissedPartitions
  ,     persistentTopicsCreateNonPartitionedTopic
  ,     persistentTopicsCreatePartitionedTopic
  ,     persistentTopicsCreateSubscription
  ,     persistentTopicsDeleteDeduplicationSnapshotInterval
  ,     persistentTopicsDeleteDelayedDeliveryPolicies
  ,     persistentTopicsDeleteInactiveTopicPolicies
  ,     persistentTopicsDeleteMaxUnackedMessagesOnConsumer
  ,     persistentTopicsDeleteMaxUnackedMessagesOnSubscription
  ,     persistentTopicsDeletePartitionedTopic
  ,     persistentTopicsDeleteShadowTopics
  ,     persistentTopicsDeleteSubscription
  ,     persistentTopicsDeleteTopic
  ,     persistentTopicsDeleteTopicPolicies
  ,     persistentTopicsExamineMessage
  ,     persistentTopicsExpireMessagesForAllSubscriptions
  ,     persistentTopicsExpireTopicMessages
  ,     persistentTopicsExpireTopicMessagesByExpireTimeInSeconds
  ,     persistentTopicsGetAutoSubscriptionCreation
  ,     persistentTopicsGetBacklog
  ,     persistentTopicsGetBacklogQuotaMap
  ,     persistentTopicsGetBacklogSizeByMessageId
  ,     persistentTopicsGetCompactionThreshold
  ,     persistentTopicsGetDeduplication
  ,     persistentTopicsGetDeduplicationSnapshotInterval
  ,     persistentTopicsGetDelayedDeliveryPolicies
  ,     persistentTopicsGetDispatchRate
  ,     persistentTopicsGetDispatcherPauseOnAckStatePersistent
  ,     persistentTopicsGetEntryFilters
  ,     persistentTopicsGetInactiveTopicPolicies
  ,     persistentTopicsGetInternalStats
  ,     persistentTopicsGetLastMessageId
  ,     persistentTopicsGetList
  ,     persistentTopicsGetManagedLedgerInfo
  ,     persistentTopicsGetMaxConsumers
  ,     persistentTopicsGetMaxConsumersPerSubscription
  ,     persistentTopicsGetMaxMessageSize
  ,     persistentTopicsGetMaxProducers
  ,     persistentTopicsGetMaxSubscriptionsPerTopic
  ,     persistentTopicsGetMaxUnackedMessagesOnConsumer
  ,     persistentTopicsGetMaxUnackedMessagesOnSubscription
  ,     persistentTopicsGetMessageById
  ,     persistentTopicsGetMessageIdByTimestamp
  ,     persistentTopicsGetMessageTTL
  ,     persistentTopicsGetOffloadPolicies
  ,     persistentTopicsGetPartitionedMetadata
  ,     persistentTopicsGetPartitionedStats
  ,     persistentTopicsGetPartitionedStatsInternal
  ,     persistentTopicsGetPartitionedTopicList
  ,     persistentTopicsGetPermissionsOnTopic
  ,     persistentTopicsGetPersistence
  ,     persistentTopicsGetProperties
  ,     persistentTopicsGetPublishRate
  ,     persistentTopicsGetReplicatedSubscriptionStatus
  ,     persistentTopicsGetReplicationClusters
  ,     persistentTopicsGetReplicatorDispatchRate
  ,     persistentTopicsGetRetention
  ,     persistentTopicsGetSchemaCompatibilityStrategy
  ,     persistentTopicsGetSchemaValidationEnforced
  ,     persistentTopicsGetShadowTopics
  ,     persistentTopicsGetStats
  ,     persistentTopicsGetSubscribeRate
  ,     persistentTopicsGetSubscriptionDispatchRate
  ,     persistentTopicsGetSubscriptionLevelDispatchRate
  ,     persistentTopicsGetSubscriptionProperties
  ,     persistentTopicsGetSubscriptionTypesEnabled
  ,     persistentTopicsGetSubscriptions
  ,     persistentTopicsGrantPermissionsOnTopic
  ,     persistentTopicsOffloadStatus
  ,     persistentTopicsPeekNthMessage
  ,     persistentTopicsRemoveAutoSubscriptionCreation
  ,     persistentTopicsRemoveBacklogQuota
  ,     persistentTopicsRemoveCompactionThreshold
  ,     persistentTopicsRemoveDeduplication
  ,     persistentTopicsRemoveDispatchRate
  ,     persistentTopicsRemoveDispatcherPauseOnAckStatePersistent
  ,     persistentTopicsRemoveEntryFilters
  ,     persistentTopicsRemoveMaxConsumers
  ,     persistentTopicsRemoveMaxConsumersPerSubscription
  ,     persistentTopicsRemoveMaxMessageSize
  ,     persistentTopicsRemoveMaxProducers
  ,     persistentTopicsRemoveMaxSubscriptionsPerTopic
  ,     persistentTopicsRemoveMessageTTL
  ,     persistentTopicsRemoveOffloadPolicies
  ,     persistentTopicsRemovePersistence
  ,     persistentTopicsRemoveProperties
  ,     persistentTopicsRemovePublishRate
  ,     persistentTopicsRemoveReplicationClusters
  ,     persistentTopicsRemoveReplicatorDispatchRate
  ,     persistentTopicsRemoveRetention
  ,     persistentTopicsRemoveSchemaCompatibilityStrategy
  ,     persistentTopicsRemoveSubscribeRate
  ,     persistentTopicsRemoveSubscriptionDispatchRate
  ,     persistentTopicsRemoveSubscriptionLevelDispatchRate
  ,     persistentTopicsRemoveSubscriptionTypesEnabled
  ,     persistentTopicsResetCursor
  ,     persistentTopicsResetCursorOnPosition
  ,     persistentTopicsRevokePermissionsOnTopic
  ,     persistentTopicsSetAutoSubscriptionCreation
  ,     persistentTopicsSetBacklogQuota
  ,     persistentTopicsSetCompactionThreshold
  ,     persistentTopicsSetDeduplication
  ,     persistentTopicsSetDeduplicationSnapshotInterval
  ,     persistentTopicsSetDelayedDeliveryPolicies
  ,     persistentTopicsSetDispatchRate
  ,     persistentTopicsSetDispatcherPauseOnAckStatePersistent
  ,     persistentTopicsSetEntryFilters
  ,     persistentTopicsSetInactiveTopicPolicies
  ,     persistentTopicsSetMaxConsumers
  ,     persistentTopicsSetMaxConsumersPerSubscription
  ,     persistentTopicsSetMaxMessageSize
  ,     persistentTopicsSetMaxProducers
  ,     persistentTopicsSetMaxSubscriptionsPerTopic
  ,     persistentTopicsSetMaxUnackedMessagesOnConsumer
  ,     persistentTopicsSetMaxUnackedMessagesOnSubscription
  ,     persistentTopicsSetMessageTTL
  ,     persistentTopicsSetOffloadPolicies
  ,     persistentTopicsSetPersistence
  ,     persistentTopicsSetPublishRate
  ,     persistentTopicsSetReplicatedSubscriptionStatus
  ,     persistentTopicsSetReplicationClusters
  ,     persistentTopicsSetReplicatorDispatchRate
  ,     persistentTopicsSetRetention
  ,     persistentTopicsSetSchemaCompatibilityStrategy
  ,     persistentTopicsSetSchemaValidationEnforced
  ,     persistentTopicsSetShadowTopics
  ,     persistentTopicsSetSubscribeRate
  ,     persistentTopicsSetSubscriptionDispatchRate
  ,     persistentTopicsSetSubscriptionLevelDispatchRate
  ,     persistentTopicsSetSubscriptionTypesEnabled
  ,     persistentTopicsSkipAllMessages
  ,     persistentTopicsSkipMessages
  ,     persistentTopicsTerminate
  ,     persistentTopicsTerminatePartitionedTopic
  ,     persistentTopicsTriggerOffload
  ,     persistentTopicsTrimTopic
  ,     persistentTopicsTruncateTopic
  ,     persistentTopicsUnloadTopic
  ,     persistentTopicsUpdatePartitionedTopic
  ,     persistentTopicsUpdateProperties
  ,     persistentTopicsUpdateSubscriptionProperties
  ,     resourceQuotasGetDefaultResourceQuota
  ,     resourceQuotasGetNamespaceBundleResourceQuota
  ,     resourceQuotasRemoveNamespaceBundleResourceQuota
  ,     resourceQuotasSetDefaultResourceQuota
  ,     resourceQuotasSetNamespaceBundleResourceQuota
  ,     resourceGroupsCreateOrUpdateResourceGroup
  ,     resourceGroupsDeleteResourceGroup
  ,     resourceGroupsGetResourceGroup
  ,     resourceGroupsGetResourceGroups
  ,     schemasResourceDeleteSchema
  ,     schemasResourceGetAllSchemas
  ,     schemasResourceGetSchema
  ,     schemasResourceGetSchemaByVersion
  ,     schemasResourceGetSchemaMetadata
  ,     schemasResourceGetVersionBySchema
  ,     schemasResourcePostSchema
  ,     schemasResourceTestCompatibility
  ,     tenantsBaseCreateTenant
  ,     tenantsBaseDeleteTenant
  ,     tenantsBaseGetTenantAdmin
  ,     tenantsBaseGetTenants
  ,     tenantsBaseUpdateTenant
  , BookiesDeleteBookieRackInfoParameters (..)
  , BookiesGetBookieRackInfoParameters (..)
  , BookiesUpdateBookieRackInfoParameters (..)
  , BrokerStatsBaseGetAllocatorStatsParameters (..)
  , BrokerStatsGetBrokerResourceAvailabilityParameters (..)
  , BrokersBaseDeleteDynamicConfigurationParameters (..)
  , BrokersBaseGetActiveBrokersByClusterParameters (..)
  , BrokersBaseGetOwnedNamespacesParameters (..)
  , BrokersBaseHealthCheckParameters (..)
  , BrokersBaseShutDownBrokerGracefullyParameters (..)
  , BrokersBaseUpdateDynamicConfigurationParameters (..)
  , ClustersBaseCreateClusterParameters (..)
  , ClustersBaseDeleteClusterParameters (..)
  , ClustersBaseDeleteFailureDomainParameters (..)
  , ClustersBaseDeleteNamespaceIsolationPolicyParameters (..)
  , ClustersBaseGetBrokerWithNamespaceIsolationPolicyParameters (..)
  , ClustersBaseGetBrokersWithNamespaceIsolationPolicyParameters (..)
  , ClustersBaseGetClusterParameters (..)
  , ClustersBaseGetClusterMigrationParameters (..)
  , ClustersBaseGetDomainParameters (..)
  , ClustersBaseGetFailureDomainsParameters (..)
  , ClustersBaseGetNamespaceIsolationPoliciesParameters (..)
  , ClustersBaseGetNamespaceIsolationPolicyParameters (..)
  , ClustersBaseGetPeerClusterParameters (..)
  , ClustersBaseSetFailureDomainParameters (..)
  , ClustersBaseSetNamespaceIsolationPolicyParameters (..)
  , ClustersBaseSetPeerClusterNamesParameters (..)
  , ClustersBaseUpdateClusterParameters (..)
  , ClustersBaseUpdateClusterMigrationParameters (..)
  , WorkerDrainAtLeaderParameters (..)
  , WorkerGetDrainStatusFromLeaderParameters (..)
  , NamespacesClearNamespaceBacklogParameters (..)
  , NamespacesClearNamespaceBacklogForSubscriptionParameters (..)
  , NamespacesClearNamespaceBundleBacklogParameters (..)
  , NamespacesClearNamespaceBundleBacklogForSubscriptionParameters (..)
  , NamespacesClearOffloadDeletionLagParameters (..)
  , NamespacesClearPropertiesParameters (..)
  , NamespacesCreateNamespaceParameters (..)
  , NamespacesDeleteBookieAffinityGroupParameters (..)
  , NamespacesDeleteCompactionThresholdParameters (..)
  , NamespacesDeleteDispatchRateParameters (..)
  , NamespacesDeleteNamespaceParameters (..)
  , NamespacesDeleteNamespaceBundleParameters (..)
  , NamespacesDeletePersistenceParameters (..)
  , NamespacesDeleteSubscribeRateParameters (..)
  , NamespacesDeleteSubscriptionDispatchRateParameters (..)
  , NamespacesGetAntiAffinityNamespacesParameters (..)
  , NamespacesGetAutoSubscriptionCreationParameters (..)
  , NamespacesGetAutoTopicCreationParameters (..)
  , NamespacesGetBacklogQuotaMapParameters (..)
  , NamespacesGetBookieAffinityGroupParameters (..)
  , NamespacesGetBundlesDataParameters (..)
  , NamespacesGetCompactionThresholdParameters (..)
  , NamespacesGetDeduplicationParameters (..)
  , NamespacesGetDeduplicationSnapshotIntervalParameters (..)
  , NamespacesGetDelayedDeliveryPoliciesParameters (..)
  , NamespacesGetDispatchRateParameters (..)
  , NamespacesGetDispatcherPauseOnAckStatePersistentParameters (..)
  , NamespacesGetEncryptionRequiredParameters (..)
  , NamespacesGetEntryFiltersPerTopicParameters (..)
  , NamespacesGetInactiveTopicPoliciesParameters (..)
  , NamespacesGetIsAllowAutoUpdateSchemaParameters (..)
  , NamespacesGetMaxConsumersPerSubscriptionParameters (..)
  , NamespacesGetMaxConsumersPerTopicParameters (..)
  , NamespacesGetMaxProducersPerTopicParameters (..)
  , NamespacesGetMaxSubscriptionsPerTopicParameters (..)
  , NamespacesGetMaxTopicsPerNamespaceParameters (..)
  , NamespacesGetMaxUnackedMessagesPerConsumerParameters (..)
  , NamespacesGetMaxUnackedmessagesPerSubscriptionParameters (..)
  , NamespacesGetNamespaceAllowedClustersParameters (..)
  , NamespacesGetNamespaceAntiAffinityGroupParameters (..)
  , NamespacesGetNamespaceMessageTTLParameters (..)
  , NamespacesGetNamespaceReplicationClustersParameters (..)
  , NamespacesGetNamespaceResourceGroupParameters (..)
  , NamespacesGetOffloadDeletionLagParameters (..)
  , NamespacesGetOffloadPoliciesParameters (..)
  , NamespacesGetOffloadThresholdParameters (..)
  , NamespacesGetOffloadThresholdInSecondsParameters (..)
  , NamespacesGetPermissionOnSubscriptionParameters (..)
  , NamespacesGetPermissionsParameters (..)
  , NamespacesGetPersistenceParameters (..)
  , NamespacesGetPoliciesParameters (..)
  , NamespacesGetPropertiesParameters (..)
  , NamespacesGetPropertyParameters (..)
  , NamespacesGetReplicatorDispatchRateParameters (..)
  , NamespacesGetRetentionParameters (..)
  , NamespacesGetSchemaAutoUpdateCompatibilityStrategyParameters (..)
  , NamespacesGetSchemaCompatibilityStrategyParameters (..)
  , NamespacesGetSchemaValidtionEnforcedParameters (..)
  , NamespacesGetSubscribeRateParameters (..)
  , NamespacesGetSubscriptionAuthModeParameters (..)
  , NamespacesGetSubscriptionDispatchRateParameters (..)
  , NamespacesGetSubscriptionExpirationTimeParameters (..)
  , NamespacesGetSubscriptionTypesEnabledParameters (..)
  , NamespacesGetTenantNamespacesParameters (..)
  , NamespacesGetTopicHashPositionsParameters (..)
  , NamespacesGetTopicsParameters (..)
  , NamespacesGrantPermissionOnNamespaceParameters (..)
  , NamespacesModifyDeduplicationParameters (..)
  , NamespacesModifyEncryptionRequiredParameters (..)
  , NamespacesRemoveAutoSubscriptionCreationParameters (..)
  , NamespacesRemoveAutoTopicCreationParameters (..)
  , NamespacesRemoveBacklogQuotaParameters (..)
  , NamespacesRemoveDeduplicationParameters (..)
  , NamespacesRemoveDelayedDeliveryPoliciesParameters (..)
  , NamespacesRemoveDispatcherPauseOnAckStatePersistentParameters (..)
  , NamespacesRemoveInactiveTopicPoliciesParameters (..)
  , NamespacesRemoveMaxConsumersPerSubscriptionParameters (..)
  , NamespacesRemoveMaxConsumersPerTopicParameters (..)
  , NamespacesRemoveMaxProducersPerTopicParameters (..)
  , NamespacesRemoveMaxSubscriptionsPerTopicParameters (..)
  , NamespacesRemoveMaxTopicsPerNamespaceParameters (..)
  , NamespacesRemoveMaxUnackedmessagesPerConsumerParameters (..)
  , NamespacesRemoveMaxUnackedmessagesPerSubscriptionParameters (..)
  , NamespacesRemoveNamespaceAntiAffinityGroupParameters (..)
  , NamespacesRemoveNamespaceEntryFiltersParameters (..)
  , NamespacesRemoveNamespaceMessageTTLParameters (..)
  , NamespacesRemoveNamespaceResourceGroupParameters (..)
  , NamespacesRemoveOffloadPoliciesParameters (..)
  , NamespacesRemovePropertyParameters (..)
  , NamespacesRemoveReplicatorDispatchRateParameters (..)
  , NamespacesRemoveRetentionParameters (..)
  , NamespacesRemoveSubscriptionExpirationTimeParameters (..)
  , NamespacesRemoveSubscriptionTypesEnabledParameters (..)
  , NamespacesRevokePermissionsOnNamespaceParameters (..)
  , NamespacesScanOffloadedLedgersParameters (..)
  , NamespacesSetAutoSubscriptionCreationParameters (..)
  , NamespacesSetAutoTopicCreationParameters (..)
  , NamespacesSetBacklogQuotaParameters (..)
  , NamespacesSetBookieAffinityGroupParameters (..)
  , NamespacesSetCompactionThresholdParameters (..)
  , NamespacesSetDeduplicationSnapshotIntervalParameters (..)
  , NamespacesSetDelayedDeliveryPoliciesParameters (..)
  , NamespacesSetDispatchRateParameters (..)
  , NamespacesSetDispatcherPauseOnAckStatePersistentParameters (..)
  , NamespacesSetEntryFiltersPerTopicParameters (..)
  , NamespacesSetInactiveTopicPoliciesParameters (..)
  , NamespacesSetIsAllowAutoUpdateSchemaParameters (..)
  , NamespacesSetMaxConsumersPerSubscriptionParameters (..)
  , NamespacesSetMaxConsumersPerTopicParameters (..)
  , NamespacesSetMaxProducersPerTopicParameters (..)
  , NamespacesSetMaxSubscriptionsPerTopicParameters (..)
  , NamespacesSetMaxTopicsPerNamespaceParameters (..)
  , NamespacesSetMaxUnackedMessagesPerConsumerParameters (..)
  , NamespacesSetMaxUnackedMessagesPerSubscriptionParameters (..)
  , NamespacesSetNamespaceAllowedClustersParameters (..)
  , NamespacesSetNamespaceAntiAffinityGroupParameters (..)
  , NamespacesSetNamespaceMessageTTLParameters (..)
  , NamespacesSetNamespaceReplicationClustersParameters (..)
  , NamespacesSetNamespaceResourceGroupParameters (..)
  , NamespacesSetOffloadDeletionLagParameters (..)
  , NamespacesSetOffloadPoliciesParameters (..)
  , NamespacesSetOffloadThresholdParameters (..)
  , NamespacesSetOffloadThresholdInSecondsParameters (..)
  , NamespacesSetPersistenceParameters (..)
  , NamespacesSetPropertiesParameters (..)
  , NamespacesSetPropertyParameters (..)
  , NamespacesSetReplicatorDispatchRateParameters (..)
  , NamespacesSetRetentionParameters (..)
  , NamespacesSetSchemaAutoUpdateCompatibilityStrategyParameters (..)
  , NamespacesSetSchemaCompatibilityStrategyParameters (..)
  , NamespacesSetSchemaValidationEnforcedParameters (..)
  , NamespacesSetSubscribeRateParameters (..)
  , NamespacesSetSubscriptionAuthModeParameters (..)
  , NamespacesSetSubscriptionDispatchRateParameters (..)
  , NamespacesSetSubscriptionExpirationTimeParameters (..)
  , NamespacesSetSubscriptionTypesEnabledParameters (..)
  , NamespacesSplitNamespaceBundleParameters (..)
  , NamespacesUnloadNamespaceParameters (..)
  , NamespacesUnloadNamespaceBundleParameters (..)
  , NamespacesUnsubscribeNamespaceParameters (..)
  , NamespacesUnsubscribeNamespaceBundleParameters (..)
  , NonPersistentTopicsAnalyzeSubscriptionBacklogParameters (..)
  , NonPersistentTopicsCompactParameters (..)
  , NonPersistentTopicsCompactionStatusParameters (..)
  , NonPersistentTopicsCreateMissedPartitionsParameters (..)
  , NonPersistentTopicsCreateNonPartitionedTopicParameters (..)
  , NonPersistentTopicsCreatePartitionedTopicParameters (..)
  , NonPersistentTopicsCreateSubscriptionParameters (..)
  , NonPersistentTopicsDeleteDeduplicationSnapshotIntervalParameters (..)
  , NonPersistentTopicsDeleteDelayedDeliveryPoliciesParameters (..)
  , NonPersistentTopicsDeleteInactiveTopicPoliciesParameters (..)
  , NonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters (..)
  , NonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters (..)
  , NonPersistentTopicsDeletePartitionedTopicParameters (..)
  , NonPersistentTopicsDeleteShadowTopicsParameters (..)
  , NonPersistentTopicsDeleteSubscriptionParameters (..)
  , NonPersistentTopicsDeleteTopicParameters (..)
  , NonPersistentTopicsDeleteTopicPoliciesParameters (..)
  , NonPersistentTopicsExamineMessageParameters (..)
  , NonPersistentTopicsExpireMessagesForAllSubscriptionsParameters (..)
  , NonPersistentTopicsGetAutoSubscriptionCreationParameters (..)
  , NonPersistentTopicsGetBacklogParameters (..)
  , NonPersistentTopicsGetBacklogQuotaMapParameters (..)
  , NonPersistentTopicsGetBacklogSizeByMessageIdParameters (..)
  , NonPersistentTopicsGetCompactionThresholdParameters (..)
  , NonPersistentTopicsGetDeduplicationParameters (..)
  , NonPersistentTopicsGetDeduplicationSnapshotIntervalParameters (..)
  , NonPersistentTopicsGetDelayedDeliveryPoliciesParameters (..)
  , NonPersistentTopicsGetDispatchRateParameters (..)
  , NonPersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters (..)
  , NonPersistentTopicsGetEntryFiltersParameters (..)
  , NonPersistentTopicsGetExpireTopicMessagesParameters (..)
  , NonPersistentTopicsGetInactiveTopicPoliciesParameters (..)
  , NonPersistentTopicsGetInternalStatsParameters (..)
  , NonPersistentTopicsGetLastMessageIdParameters (..)
  , NonPersistentTopicsGetListParameters (..)
  , NonPersistentTopicsGetListFromBundleParameters (..)
  , NonPersistentTopicsGetManagedLedgerInfoParameters (..)
  , NonPersistentTopicsGetMaxConsumersParameters (..)
  , NonPersistentTopicsGetMaxConsumersPerSubscriptionParameters (..)
  , NonPersistentTopicsGetMaxMessageSizeParameters (..)
  , NonPersistentTopicsGetMaxProducersParameters (..)
  , NonPersistentTopicsGetMaxSubscriptionsPerTopicParameters (..)
  , NonPersistentTopicsGetMaxUnackedMessagesOnConsumerParameters (..)
  , NonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters (..)
  , NonPersistentTopicsGetMessageByIdParameters (..)
  , NonPersistentTopicsGetMessageIdByTimestampParameters (..)
  , NonPersistentTopicsGetMessageTTLParameters (..)
  , NonPersistentTopicsGetOffloadPoliciesParameters (..)
  , NonPersistentTopicsGetPartitionedMetadataParameters (..)
  , NonPersistentTopicsGetPartitionedStatsParameters (..)
  , NonPersistentTopicsGetPartitionedStatsInternalParameters (..)
  , NonPersistentTopicsGetPartitionedTopicListParameters (..)
  , NonPersistentTopicsGetPermissionsOnTopicParameters (..)
  , NonPersistentTopicsGetPersistenceParameters (..)
  , NonPersistentTopicsGetPropertiesParameters (..)
  , NonPersistentTopicsGetPublishRateParameters (..)
  , NonPersistentTopicsGetReplicatedSubscriptionStatusParameters (..)
  , NonPersistentTopicsGetReplicationClustersParameters (..)
  , NonPersistentTopicsGetReplicatorDispatchRateParameters (..)
  , NonPersistentTopicsGetRetentionParameters (..)
  , NonPersistentTopicsGetSchemaCompatibilityStrategyParameters (..)
  , NonPersistentTopicsGetSchemaValidationEnforcedParameters (..)
  , NonPersistentTopicsGetShadowTopicsParameters (..)
  , NonPersistentTopicsGetStatsParameters (..)
  , NonPersistentTopicsGetSubscribeRateParameters (..)
  , NonPersistentTopicsGetSubscriptionDispatchRateParameters (..)
  , NonPersistentTopicsGetSubscriptionLevelDispatchRateParameters (..)
  , NonPersistentTopicsGetSubscriptionPropertiesParameters (..)
  , NonPersistentTopicsGetSubscriptionTypesEnabledParameters (..)
  , NonPersistentTopicsGetSubscriptionsParameters (..)
  , NonPersistentTopicsGrantPermissionsOnTopicParameters (..)
  , NonPersistentTopicsOffloadStatusParameters (..)
  , NonPersistentTopicsPeekNthMessageParameters (..)
  , NonPersistentTopicsPostExpireTopicMessagesParameters (..)
  , NonPersistentTopicsRemoveAutoSubscriptionCreationParameters (..)
  , NonPersistentTopicsRemoveBacklogQuotaParameters (..)
  , NonPersistentTopicsRemoveCompactionThresholdParameters (..)
  , NonPersistentTopicsRemoveDeduplicationParameters (..)
  , NonPersistentTopicsRemoveDispatchRateParameters (..)
  , NonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters (..)
  , NonPersistentTopicsRemoveEntryFiltersParameters (..)
  , NonPersistentTopicsRemoveMaxConsumersParameters (..)
  , NonPersistentTopicsRemoveMaxConsumersPerSubscriptionParameters (..)
  , NonPersistentTopicsRemoveMaxMessageSizeParameters (..)
  , NonPersistentTopicsRemoveMaxProducersParameters (..)
  , NonPersistentTopicsRemoveMaxSubscriptionsPerTopicParameters (..)
  , NonPersistentTopicsRemoveMessageTTLParameters (..)
  , NonPersistentTopicsRemoveOffloadPoliciesParameters (..)
  , NonPersistentTopicsRemovePersistenceParameters (..)
  , NonPersistentTopicsRemovePropertiesParameters (..)
  , NonPersistentTopicsRemovePublishRateParameters (..)
  , NonPersistentTopicsRemoveReplicationClustersParameters (..)
  , NonPersistentTopicsRemoveReplicatorDispatchRateParameters (..)
  , NonPersistentTopicsRemoveRetentionParameters (..)
  , NonPersistentTopicsRemoveSchemaCompatibilityStrategyParameters (..)
  , NonPersistentTopicsRemoveSubscribeRateParameters (..)
  , NonPersistentTopicsRemoveSubscriptionDispatchRateParameters (..)
  , NonPersistentTopicsRemoveSubscriptionLevelDispatchRateParameters (..)
  , NonPersistentTopicsRemoveSubscriptionTypesEnabledParameters (..)
  , NonPersistentTopicsResetCursorParameters (..)
  , NonPersistentTopicsResetCursorOnPositionParameters (..)
  , NonPersistentTopicsRevokePermissionsOnTopicParameters (..)
  , NonPersistentTopicsSetAutoSubscriptionCreationParameters (..)
  , NonPersistentTopicsSetBacklogQuotaParameters (..)
  , NonPersistentTopicsSetCompactionThresholdParameters (..)
  , NonPersistentTopicsSetDeduplicationParameters (..)
  , NonPersistentTopicsSetDeduplicationSnapshotIntervalParameters (..)
  , NonPersistentTopicsSetDelayedDeliveryPoliciesParameters (..)
  , NonPersistentTopicsSetDispatchRateParameters (..)
  , NonPersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters (..)
  , NonPersistentTopicsSetEntryFiltersParameters (..)
  , NonPersistentTopicsSetInactiveTopicPoliciesParameters (..)
  , NonPersistentTopicsSetMaxConsumersParameters (..)
  , NonPersistentTopicsSetMaxConsumersPerSubscriptionParameters (..)
  , NonPersistentTopicsSetMaxMessageSizeParameters (..)
  , NonPersistentTopicsSetMaxProducersParameters (..)
  , NonPersistentTopicsSetMaxSubscriptionsPerTopicParameters (..)
  , NonPersistentTopicsSetMaxUnackedMessagesOnConsumerParameters (..)
  , NonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters (..)
  , NonPersistentTopicsSetMessageTTLParameters (..)
  , NonPersistentTopicsSetOffloadPoliciesParameters (..)
  , NonPersistentTopicsSetPersistenceParameters (..)
  , NonPersistentTopicsSetPublishRateParameters (..)
  , NonPersistentTopicsSetReplicatedSubscriptionStatusParameters (..)
  , NonPersistentTopicsSetReplicationClustersParameters (..)
  , NonPersistentTopicsSetReplicatorDispatchRateParameters (..)
  , NonPersistentTopicsSetRetentionParameters (..)
  , NonPersistentTopicsSetSchemaCompatibilityStrategyParameters (..)
  , NonPersistentTopicsSetSchemaValidationEnforcedParameters (..)
  , NonPersistentTopicsSetShadowTopicsParameters (..)
  , NonPersistentTopicsSetSubscribeRateParameters (..)
  , NonPersistentTopicsSetSubscriptionDispatchRateParameters (..)
  , NonPersistentTopicsSetSubscriptionLevelDispatchRateParameters (..)
  , NonPersistentTopicsSetSubscriptionTypesEnabledParameters (..)
  , NonPersistentTopicsSkipAllMessagesParameters (..)
  , NonPersistentTopicsSkipMessagesParameters (..)
  , NonPersistentTopicsTerminateParameters (..)
  , NonPersistentTopicsTerminatePartitionedTopicParameters (..)
  , NonPersistentTopicsTriggerOffloadParameters (..)
  , NonPersistentTopicsTrimTopicParameters (..)
  , NonPersistentTopicsTruncateTopicParameters (..)
  , NonPersistentTopicsUnloadTopicParameters (..)
  , NonPersistentTopicsUpdatePartitionedTopicParameters (..)
  , NonPersistentTopicsUpdatePropertiesParameters (..)
  , NonPersistentTopicsUpdateSubscriptionPropertiesParameters (..)
  , PersistentTopicsAnalyzeSubscriptionBacklogParameters (..)
  , PersistentTopicsCompactParameters (..)
  , PersistentTopicsCompactionStatusParameters (..)
  , PersistentTopicsCreateMissedPartitionsParameters (..)
  , PersistentTopicsCreateNonPartitionedTopicParameters (..)
  , PersistentTopicsCreatePartitionedTopicParameters (..)
  , PersistentTopicsCreateSubscriptionParameters (..)
  , PersistentTopicsDeleteDeduplicationSnapshotIntervalParameters (..)
  , PersistentTopicsDeleteDelayedDeliveryPoliciesParameters (..)
  , PersistentTopicsDeleteInactiveTopicPoliciesParameters (..)
  , PersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters (..)
  , PersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters (..)
  , PersistentTopicsDeletePartitionedTopicParameters (..)
  , PersistentTopicsDeleteShadowTopicsParameters (..)
  , PersistentTopicsDeleteSubscriptionParameters (..)
  , PersistentTopicsDeleteTopicParameters (..)
  , PersistentTopicsDeleteTopicPoliciesParameters (..)
  , PersistentTopicsExamineMessageParameters (..)
  , PersistentTopicsExpireMessagesForAllSubscriptionsParameters (..)
  , PersistentTopicsExpireTopicMessagesParameters (..)
  , PersistentTopicsExpireTopicMessagesByExpireTimeInSecondsParameters (..)
  , PersistentTopicsGetAutoSubscriptionCreationParameters (..)
  , PersistentTopicsGetBacklogParameters (..)
  , PersistentTopicsGetBacklogQuotaMapParameters (..)
  , PersistentTopicsGetBacklogSizeByMessageIdParameters (..)
  , PersistentTopicsGetCompactionThresholdParameters (..)
  , PersistentTopicsGetDeduplicationParameters (..)
  , PersistentTopicsGetDeduplicationSnapshotIntervalParameters (..)
  , PersistentTopicsGetDelayedDeliveryPoliciesParameters (..)
  , PersistentTopicsGetDispatchRateParameters (..)
  , PersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters (..)
  , PersistentTopicsGetEntryFiltersParameters (..)
  , PersistentTopicsGetInactiveTopicPoliciesParameters (..)
  , PersistentTopicsGetInternalStatsParameters (..)
  , PersistentTopicsGetLastMessageIdParameters (..)
  , PersistentTopicsGetListParameters (..)
  , PersistentTopicsGetManagedLedgerInfoParameters (..)
  , PersistentTopicsGetMaxConsumersParameters (..)
  , PersistentTopicsGetMaxConsumersPerSubscriptionParameters (..)
  , PersistentTopicsGetMaxMessageSizeParameters (..)
  , PersistentTopicsGetMaxProducersParameters (..)
  , PersistentTopicsGetMaxSubscriptionsPerTopicParameters (..)
  , PersistentTopicsGetMaxUnackedMessagesOnConsumerParameters (..)
  , PersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters (..)
  , PersistentTopicsGetMessageByIdParameters (..)
  , PersistentTopicsGetMessageIdByTimestampParameters (..)
  , PersistentTopicsGetMessageTTLParameters (..)
  , PersistentTopicsGetOffloadPoliciesParameters (..)
  , PersistentTopicsGetPartitionedMetadataParameters (..)
  , PersistentTopicsGetPartitionedStatsParameters (..)
  , PersistentTopicsGetPartitionedStatsInternalParameters (..)
  , PersistentTopicsGetPartitionedTopicListParameters (..)
  , PersistentTopicsGetPermissionsOnTopicParameters (..)
  , PersistentTopicsGetPersistenceParameters (..)
  , PersistentTopicsGetPropertiesParameters (..)
  , PersistentTopicsGetPublishRateParameters (..)
  , PersistentTopicsGetReplicatedSubscriptionStatusParameters (..)
  , PersistentTopicsGetReplicationClustersParameters (..)
  , PersistentTopicsGetReplicatorDispatchRateParameters (..)
  , PersistentTopicsGetRetentionParameters (..)
  , PersistentTopicsGetSchemaCompatibilityStrategyParameters (..)
  , PersistentTopicsGetSchemaValidationEnforcedParameters (..)
  , PersistentTopicsGetShadowTopicsParameters (..)
  , PersistentTopicsGetStatsParameters (..)
  , PersistentTopicsGetSubscribeRateParameters (..)
  , PersistentTopicsGetSubscriptionDispatchRateParameters (..)
  , PersistentTopicsGetSubscriptionLevelDispatchRateParameters (..)
  , PersistentTopicsGetSubscriptionPropertiesParameters (..)
  , PersistentTopicsGetSubscriptionTypesEnabledParameters (..)
  , PersistentTopicsGetSubscriptionsParameters (..)
  , PersistentTopicsGrantPermissionsOnTopicParameters (..)
  , PersistentTopicsOffloadStatusParameters (..)
  , PersistentTopicsPeekNthMessageParameters (..)
  , PersistentTopicsRemoveAutoSubscriptionCreationParameters (..)
  , PersistentTopicsRemoveBacklogQuotaParameters (..)
  , PersistentTopicsRemoveCompactionThresholdParameters (..)
  , PersistentTopicsRemoveDeduplicationParameters (..)
  , PersistentTopicsRemoveDispatchRateParameters (..)
  , PersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters (..)
  , PersistentTopicsRemoveEntryFiltersParameters (..)
  , PersistentTopicsRemoveMaxConsumersParameters (..)
  , PersistentTopicsRemoveMaxConsumersPerSubscriptionParameters (..)
  , PersistentTopicsRemoveMaxMessageSizeParameters (..)
  , PersistentTopicsRemoveMaxProducersParameters (..)
  , PersistentTopicsRemoveMaxSubscriptionsPerTopicParameters (..)
  , PersistentTopicsRemoveMessageTTLParameters (..)
  , PersistentTopicsRemoveOffloadPoliciesParameters (..)
  , PersistentTopicsRemovePersistenceParameters (..)
  , PersistentTopicsRemovePropertiesParameters (..)
  , PersistentTopicsRemovePublishRateParameters (..)
  , PersistentTopicsRemoveReplicationClustersParameters (..)
  , PersistentTopicsRemoveReplicatorDispatchRateParameters (..)
  , PersistentTopicsRemoveRetentionParameters (..)
  , PersistentTopicsRemoveSchemaCompatibilityStrategyParameters (..)
  , PersistentTopicsRemoveSubscribeRateParameters (..)
  , PersistentTopicsRemoveSubscriptionDispatchRateParameters (..)
  , PersistentTopicsRemoveSubscriptionLevelDispatchRateParameters (..)
  , PersistentTopicsRemoveSubscriptionTypesEnabledParameters (..)
  , PersistentTopicsResetCursorParameters (..)
  , PersistentTopicsResetCursorOnPositionParameters (..)
  , PersistentTopicsRevokePermissionsOnTopicParameters (..)
  , PersistentTopicsSetAutoSubscriptionCreationParameters (..)
  , PersistentTopicsSetBacklogQuotaParameters (..)
  , PersistentTopicsSetCompactionThresholdParameters (..)
  , PersistentTopicsSetDeduplicationParameters (..)
  , PersistentTopicsSetDeduplicationSnapshotIntervalParameters (..)
  , PersistentTopicsSetDelayedDeliveryPoliciesParameters (..)
  , PersistentTopicsSetDispatchRateParameters (..)
  , PersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters (..)
  , PersistentTopicsSetEntryFiltersParameters (..)
  , PersistentTopicsSetInactiveTopicPoliciesParameters (..)
  , PersistentTopicsSetMaxConsumersParameters (..)
  , PersistentTopicsSetMaxConsumersPerSubscriptionParameters (..)
  , PersistentTopicsSetMaxMessageSizeParameters (..)
  , PersistentTopicsSetMaxProducersParameters (..)
  , PersistentTopicsSetMaxSubscriptionsPerTopicParameters (..)
  , PersistentTopicsSetMaxUnackedMessagesOnConsumerParameters (..)
  , PersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters (..)
  , PersistentTopicsSetMessageTTLParameters (..)
  , PersistentTopicsSetOffloadPoliciesParameters (..)
  , PersistentTopicsSetPersistenceParameters (..)
  , PersistentTopicsSetPublishRateParameters (..)
  , PersistentTopicsSetReplicatedSubscriptionStatusParameters (..)
  , PersistentTopicsSetReplicationClustersParameters (..)
  , PersistentTopicsSetReplicatorDispatchRateParameters (..)
  , PersistentTopicsSetRetentionParameters (..)
  , PersistentTopicsSetSchemaCompatibilityStrategyParameters (..)
  , PersistentTopicsSetSchemaValidationEnforcedParameters (..)
  , PersistentTopicsSetShadowTopicsParameters (..)
  , PersistentTopicsSetSubscribeRateParameters (..)
  , PersistentTopicsSetSubscriptionDispatchRateParameters (..)
  , PersistentTopicsSetSubscriptionLevelDispatchRateParameters (..)
  , PersistentTopicsSetSubscriptionTypesEnabledParameters (..)
  , PersistentTopicsSkipAllMessagesParameters (..)
  , PersistentTopicsSkipMessagesParameters (..)
  , PersistentTopicsTerminateParameters (..)
  , PersistentTopicsTerminatePartitionedTopicParameters (..)
  , PersistentTopicsTriggerOffloadParameters (..)
  , PersistentTopicsTrimTopicParameters (..)
  , PersistentTopicsTruncateTopicParameters (..)
  , PersistentTopicsUnloadTopicParameters (..)
  , PersistentTopicsUpdatePartitionedTopicParameters (..)
  , PersistentTopicsUpdatePropertiesParameters (..)
  , PersistentTopicsUpdateSubscriptionPropertiesParameters (..)
  , ResourceQuotasGetNamespaceBundleResourceQuotaParameters (..)
  , ResourceQuotasRemoveNamespaceBundleResourceQuotaParameters (..)
  , ResourceQuotasSetDefaultResourceQuotaParameters (..)
  , ResourceQuotasSetNamespaceBundleResourceQuotaParameters (..)
  , ResourceGroupsCreateOrUpdateResourceGroupParameters (..)
  , ResourceGroupsDeleteResourceGroupParameters (..)
  , ResourceGroupsGetResourceGroupParameters (..)
  , SchemasResourceDeleteSchemaParameters (..)
  , SchemasResourceGetAllSchemasParameters (..)
  , SchemasResourceGetSchemaParameters (..)
  , SchemasResourceGetSchemaByVersionParameters (..)
  , SchemasResourceGetSchemaMetadataParameters (..)
  , SchemasResourceGetVersionBySchemaParameters (..)
  , SchemasResourcePostSchemaParameters (..)
  , SchemasResourceTestCompatibilityParameters (..)
  , TenantsBaseCreateTenantParameters (..)
  , TenantsBaseDeleteTenantParameters (..)
  , TenantsBaseGetTenantAdminParameters (..)
  , TenantsBaseUpdateTenantParameters (..)

  ) where

import           Pulsar.Admin.Types

import           Data.Aeson                         (Value)
import qualified Data.Map                           as Map
import           Data.Proxy                         (Proxy (..))
import           Data.Text                          (Text)
import qualified Data.Text                          as T
import           GHC.Generics                       (Generic)
import           Servant.API
import           Servant.Client                     (client)
import           Servant.Client.Internal.HttpClient (ClientM (..))




-- | List of elements parsed from a query.
newtype QueryList (p :: CollectionFormat) a = QueryList
  { fromQueryList :: [a]
  } deriving (Functor, Applicative, Monad, Foldable, Traversable)

-- | Formats in which a list can be encoded into a HTTP path.
data CollectionFormat
  = CommaSeparated -- ^ CSV format for multiple parameters.
  | SpaceSeparated -- ^ Also called "SSV"
  | TabSeparated -- ^ Also called "TSV"
  | PipeSeparated -- ^ `value1|value2|value2`
  | MultiParamArray -- ^ Using multiple GET parameters, e.g. `foo=bar&foo=baz`. Only for GET params.

instance FromHttpApiData a => FromHttpApiData (QueryList 'CommaSeparated a) where
  parseQueryParam = parseSeparatedQueryList ','

instance FromHttpApiData a => FromHttpApiData (QueryList 'TabSeparated a) where
  parseQueryParam = parseSeparatedQueryList '\t'

instance FromHttpApiData a => FromHttpApiData (QueryList 'SpaceSeparated a) where
  parseQueryParam = parseSeparatedQueryList ' '

instance FromHttpApiData a => FromHttpApiData (QueryList 'PipeSeparated a) where
  parseQueryParam = parseSeparatedQueryList '|'

instance FromHttpApiData a => FromHttpApiData (QueryList 'MultiParamArray a) where
  parseQueryParam = error "unimplemented FromHttpApiData for MultiParamArray collection format"

parseSeparatedQueryList :: FromHttpApiData a => Char -> Text -> Either Text (QueryList p a)
parseSeparatedQueryList char = fmap QueryList . mapM parseQueryParam . T.split (== char)

instance ToHttpApiData a => ToHttpApiData (QueryList 'CommaSeparated a) where
  toQueryParam = formatSeparatedQueryList ','

instance ToHttpApiData a => ToHttpApiData (QueryList 'TabSeparated a) where
  toQueryParam = formatSeparatedQueryList '\t'

instance ToHttpApiData a => ToHttpApiData (QueryList 'SpaceSeparated a) where
  toQueryParam = formatSeparatedQueryList ' '

instance ToHttpApiData a => ToHttpApiData (QueryList 'PipeSeparated a) where
  toQueryParam = formatSeparatedQueryList '|'

instance ToHttpApiData a => ToHttpApiData (QueryList 'MultiParamArray a) where
  toQueryParam = error "unimplemented ToHttpApiData for MultiParamArray collection format"

formatSeparatedQueryList :: ToHttpApiData a => Char ->  QueryList p a -> Text
formatSeparatedQueryList char = T.intercalate (T.singleton char) . map toQueryParam . fromQueryList

-- Clients

-- ^ 
type BookiesDeleteBookieRackInfoAPI =
      "admin" :> "v2" :> "bookies" :> "racks-info" :> Capture "bookie" Text :> Verb 'DELETE 200 '[JSON] NoContent

data BookiesDeleteBookieRackInfoParameters = BookiesDeleteBookieRackInfoParameters
  { bookiesDeleteBookieRackInfoBookie :: Text -- ^ 
  } deriving (Show, Eq, Generic)

bookiesDeleteBookieRackInfo :: BookiesDeleteBookieRackInfoParameters -> ClientM NoContent
bookiesDeleteBookieRackInfo BookiesDeleteBookieRackInfoParameters {..} = client (Proxy :: Proxy BookiesDeleteBookieRackInfoAPI) (bookiesDeleteBookieRackInfoBookie)

-- ^ 
type BookiesGetAllBookiesAPI =
      "admin" :> "v2" :> "bookies" :> "all" :> Verb 'GET 200 '[JSON] BookiesClusterInfo

bookiesGetAllBookies :: ClientM BookiesClusterInfo
bookiesGetAllBookies = client (Proxy :: Proxy BookiesGetAllBookiesAPI)

-- ^ 
type BookiesGetBookieRackInfoAPI =
      "admin" :> "v2" :> "bookies" :> "racks-info" :> Capture "bookie" Text :> Verb 'GET 200 '[JSON] BookieInfo

data BookiesGetBookieRackInfoParameters = BookiesGetBookieRackInfoParameters
  { bookiesGetBookieRackInfoBookie :: Text -- ^ 
  } deriving (Show, Eq, Generic)

bookiesGetBookieRackInfo :: BookiesGetBookieRackInfoParameters -> ClientM BookieInfo
bookiesGetBookieRackInfo BookiesGetBookieRackInfoParameters {..} = client (Proxy :: Proxy BookiesGetBookieRackInfoAPI) (bookiesGetBookieRackInfoBookie)

-- ^ 
type BookiesGetBookiesRackInfoAPI =
      "admin" :> "v2" :> "bookies" :> "racks-info" :> Verb 'GET 200 '[JSON] ((Map.Map String (Map.Map String BookieInfo)))

bookiesGetBookiesRackInfo :: ClientM (Map.Map String (Map.Map String BookieInfo))
bookiesGetBookiesRackInfo = client (Proxy :: Proxy BookiesGetBookiesRackInfoAPI)

-- ^ 
type BookiesUpdateBookieRackInfoAPI =
      "admin" :> "v2" :> "bookies" :> "racks-info" :> Capture "bookie" Text :> QueryParam "group" Text :> ReqBody '[JSON] BookieInfo :> Verb 'POST 200 '[JSON] NoContent

data BookiesUpdateBookieRackInfoParameters = BookiesUpdateBookieRackInfoParameters
  { bookiesUpdateBookieRackInfoBookie :: Text -- ^ The bookie address
  , bookiesUpdateBookieRackInfoGroup :: Text -- ^ The group
  , bookiesUpdateBookieRackInfoBody :: BookieInfo -- ^ The bookie info
  } deriving (Show, Eq, Generic)

bookiesUpdateBookieRackInfo :: BookiesUpdateBookieRackInfoParameters -> ClientM NoContent
bookiesUpdateBookieRackInfo BookiesUpdateBookieRackInfoParameters {..} = client (Proxy :: Proxy BookiesUpdateBookieRackInfoAPI) (bookiesUpdateBookieRackInfoBookie) (Just bookiesUpdateBookieRackInfoGroup) bookiesUpdateBookieRackInfoBody

-- ^ 
type BrokerStatsBaseGetAllocatorStatsAPI =
      "admin" :> "v2" :> "broker-stats" :> "allocator-stats" :> Capture "allocator" Text :> Verb 'GET 200 '[JSON] AllocatorStats

data BrokerStatsBaseGetAllocatorStatsParameters = BrokerStatsBaseGetAllocatorStatsParameters
  { brokerStatsBaseGetAllocatorStatsAllocator :: Text -- ^ 
  } deriving (Show, Eq, Generic)

brokerStatsBaseGetAllocatorStats :: BrokerStatsBaseGetAllocatorStatsParameters -> ClientM AllocatorStats
brokerStatsBaseGetAllocatorStats BrokerStatsBaseGetAllocatorStatsParameters {..} = client (Proxy :: Proxy BrokerStatsBaseGetAllocatorStatsAPI) (brokerStatsBaseGetAllocatorStatsAllocator)

-- ^ consists of topics stats & systemResourceUsage
type BrokerStatsBaseGetLoadReportAPI =
      "admin" :> "v2" :> "broker-stats" :> "load-report" :> Verb 'GET 200 '[JSON] LoadReport

brokerStatsBaseGetLoadReport :: ClientM LoadReport
brokerStatsBaseGetLoadReport = client (Proxy :: Proxy BrokerStatsBaseGetLoadReportAPI)

-- ^ 
type BrokerStatsBaseGetMBeansAPI =
      "admin" :> "v2" :> "broker-stats" :> "mbeans" :> Verb 'GET 200 '[JSON] [Metrics]

brokerStatsBaseGetMBeans :: ClientM [Metrics]
brokerStatsBaseGetMBeans = client (Proxy :: Proxy BrokerStatsBaseGetMBeansAPI)

-- ^ Requested should be executed by Monitoring agent on each broker to fetch the metrics
type BrokerStatsBaseGetMetricsAPI =
      "admin" :> "v2" :> "broker-stats" :> "metrics" :> Verb 'GET 200 '[JSON] [Metrics]

brokerStatsBaseGetMetrics :: ClientM [Metrics]
brokerStatsBaseGetMetrics = client (Proxy :: Proxy BrokerStatsBaseGetMetricsAPI)

-- ^ Returns a nested map structure which Swagger does not fully support for display. Structure: Map<String, Map<String, PendingBookieOpsStats>>. Please refer to this structure for details.
type BrokerStatsBaseGetPendingBookieOpsStatsAPI =
      "admin" :> "v2" :> "broker-stats" :> "bookieops" :> Verb 'GET 200 '[JSON] ((Map.Map String PendingBookieOpsStats))

brokerStatsBaseGetPendingBookieOpsStats :: ClientM (Map.Map String PendingBookieOpsStats)
brokerStatsBaseGetPendingBookieOpsStats = client (Proxy :: Proxy BrokerStatsBaseGetPendingBookieOpsStatsAPI)

-- ^ This API gives the current broker availability in percent, each resource percentage usage is calculated and thensum of all of the resource usage percent is called broker-resource-availability<br/><br/>THIS API IS ONLY FOR USE BY TESTING FOR CONFIRMING NAMESPACE ALLOCATION ALGORITHM
type BrokerStatsGetBrokerResourceAvailabilityAPI =
      "admin" :> "v2" :> "broker-stats" :> "broker-resource-availability" :> Capture "tenant" Text :> Capture "namespace" Text :> Verb 'GET 200 '[JSON] ((Map.Map String ResourceUnit))

data BrokerStatsGetBrokerResourceAvailabilityParameters = BrokerStatsGetBrokerResourceAvailabilityParameters
  { brokerStatsGetBrokerResourceAvailabilityTenant :: Text -- ^ 
  , brokerStatsGetBrokerResourceAvailabilityNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

brokerStatsGetBrokerResourceAvailability :: BrokerStatsGetBrokerResourceAvailabilityParameters -> ClientM (Map.Map String ResourceUnit)
brokerStatsGetBrokerResourceAvailability BrokerStatsGetBrokerResourceAvailabilityParameters {..} = client (Proxy :: Proxy BrokerStatsGetBrokerResourceAvailabilityAPI) (brokerStatsGetBrokerResourceAvailabilityTenant) (brokerStatsGetBrokerResourceAvailabilityNamespace)

-- ^ 
type BrokerStatsGetTopics2API =
      "admin" :> "v2" :> "broker-stats" :> "topics" :> Verb 'GET 200 '[JSON] Value

brokerStatsGetTopics2 :: ClientM Value
brokerStatsGetTopics2 = client (Proxy :: Proxy BrokerStatsGetTopics2API)

-- ^ 
type BrokersBaseBacklogQuotaCheckAPI =
      "admin" :> "v2" :> "brokers" :> "backlog-quota-check" :> Verb 'GET 200 '[JSON] NoContent

brokersBaseBacklogQuotaCheck :: ClientM NoContent
brokersBaseBacklogQuotaCheck = client (Proxy :: Proxy BrokersBaseBacklogQuotaCheckAPI)

-- ^ 
type BrokersBaseDeleteDynamicConfigurationAPI =
      "admin" :> "v2" :> "brokers" :> "configuration" :> Capture "configName" Text :> Verb 'DELETE 200 '[JSON] NoContent

data BrokersBaseDeleteDynamicConfigurationParameters = BrokersBaseDeleteDynamicConfigurationParameters
  { brokersBaseDeleteDynamicConfigurationConfigName :: Text -- ^ 
  } deriving (Show, Eq, Generic)

brokersBaseDeleteDynamicConfiguration :: BrokersBaseDeleteDynamicConfigurationParameters -> ClientM NoContent
brokersBaseDeleteDynamicConfiguration BrokersBaseDeleteDynamicConfigurationParameters {..} = client (Proxy :: Proxy BrokersBaseDeleteDynamicConfigurationAPI) (brokersBaseDeleteDynamicConfigurationConfigName)

-- ^ 
type BrokersBaseGetActiveBrokersAPI =
      "admin" :> "v2" :> "brokers" :> Verb 'GET 200 '[JSON] [Text]

brokersBaseGetActiveBrokers :: ClientM [Text]
brokersBaseGetActiveBrokers = client (Proxy :: Proxy BrokersBaseGetActiveBrokersAPI)

-- ^ 
type BrokersBaseGetActiveBrokersByClusterAPI =
      "admin" :> "v2" :> "brokers" :> Capture "cluster" Text :> Verb 'GET 200 '[JSON] [Text]

data BrokersBaseGetActiveBrokersByClusterParameters = BrokersBaseGetActiveBrokersByClusterParameters
  { brokersBaseGetActiveBrokersByClusterCluster :: Text -- ^ 
  } deriving (Show, Eq, Generic)

brokersBaseGetActiveBrokersByCluster :: BrokersBaseGetActiveBrokersByClusterParameters -> ClientM [Text]
brokersBaseGetActiveBrokersByCluster BrokersBaseGetActiveBrokersByClusterParameters {..} = client (Proxy :: Proxy BrokersBaseGetActiveBrokersByClusterAPI) (brokersBaseGetActiveBrokersByClusterCluster)

-- ^ 
type BrokersBaseGetAllDynamicConfigurationsAPI =
      "admin" :> "v2" :> "brokers" :> "configuration" :> "values" :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

brokersBaseGetAllDynamicConfigurations :: ClientM (Map.Map String Text)
brokersBaseGetAllDynamicConfigurations = client (Proxy :: Proxy BrokersBaseGetAllDynamicConfigurationsAPI)

-- ^ 
type BrokersBaseGetDynamicConfigurationNameAPI =
      "admin" :> "v2" :> "brokers" :> "configuration" :> Verb 'GET 200 '[JSON] [Text]

brokersBaseGetDynamicConfigurationName :: ClientM [Text]
brokersBaseGetDynamicConfigurationName = client (Proxy :: Proxy BrokersBaseGetDynamicConfigurationNameAPI)

-- ^ 
type BrokersBaseGetInternalConfigurationDataAPI =
      "admin" :> "v2" :> "brokers" :> "internal-configuration" :> Verb 'GET 200 '[JSON] InternalConfigurationData

brokersBaseGetInternalConfigurationData :: ClientM InternalConfigurationData
brokersBaseGetInternalConfigurationData = client (Proxy :: Proxy BrokersBaseGetInternalConfigurationDataAPI)

-- ^ 
type BrokersBaseGetLeaderBrokerAPI =
      "admin" :> "v2" :> "brokers" :> "leaderBroker" :> Verb 'GET 200 '[JSON] BrokerInfo

brokersBaseGetLeaderBroker :: ClientM BrokerInfo
brokersBaseGetLeaderBroker = client (Proxy :: Proxy BrokersBaseGetLeaderBrokerAPI)

-- ^ 
type BrokersBaseGetOwnedNamespacesAPI =
      "admin" :> "v2" :> "brokers" :> Capture "clusterName" Text :> Capture "brokerId" Text :> "ownedNamespaces" :> Verb 'GET 200 '[JSON] ((Map.Map String NamespaceOwnershipStatus))

data BrokersBaseGetOwnedNamespacesParameters = BrokersBaseGetOwnedNamespacesParameters
  { brokersBaseGetOwnedNamespacesClusterName :: Text -- ^ 
  , brokersBaseGetOwnedNamespacesBrokerId :: Text -- ^ 
  } deriving (Show, Eq, Generic)

brokersBaseGetOwnedNamespaces :: BrokersBaseGetOwnedNamespacesParameters -> ClientM (Map.Map String NamespaceOwnershipStatus)
brokersBaseGetOwnedNamespaces BrokersBaseGetOwnedNamespacesParameters {..} = client (Proxy :: Proxy BrokersBaseGetOwnedNamespacesAPI) (brokersBaseGetOwnedNamespacesClusterName) (brokersBaseGetOwnedNamespacesBrokerId)

-- ^ 
type BrokersBaseGetRuntimeConfigurationAPI =
      "admin" :> "v2" :> "brokers" :> "configuration" :> "runtime" :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

brokersBaseGetRuntimeConfiguration :: ClientM (Map.Map String Text)
brokersBaseGetRuntimeConfiguration = client (Proxy :: Proxy BrokersBaseGetRuntimeConfigurationAPI)

-- ^ 
type BrokersBaseHealthCheckAPI =
      "admin" :> "v2" :> "brokers" :> "health" :> QueryParam "topicVersion" Text :> QueryParam "brokerId" Text :> Verb 'GET 200 '[JSON] NoContent

data BrokersBaseHealthCheckParameters = BrokersBaseHealthCheckParameters
  { brokersBaseHealthCheckTopicVersion :: Maybe Text -- ^ Topic Version
  , brokersBaseHealthCheckBrokerId :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

brokersBaseHealthCheck :: BrokersBaseHealthCheckParameters -> ClientM NoContent
brokersBaseHealthCheck BrokersBaseHealthCheckParameters {..} = client (Proxy :: Proxy BrokersBaseHealthCheckAPI) (brokersBaseHealthCheckTopicVersion) (brokersBaseHealthCheckBrokerId)

-- ^ 
type BrokersBaseIsReadyAPI =
      "admin" :> "v2" :> "brokers" :> "ready" :> Verb 'GET 200 '[JSON] NoContent

brokersBaseIsReady :: ClientM NoContent
brokersBaseIsReady = client (Proxy :: Proxy BrokersBaseIsReadyAPI)

-- ^ 
type BrokersBaseShutDownBrokerGracefullyAPI =
      "admin" :> "v2" :> "brokers" :> "shutdown" :> QueryParam "maxConcurrentUnloadPerSec" Int :> QueryParam "forcedTerminateTopic" Bool :> Verb 'POST 200 '[JSON] NoContent

data BrokersBaseShutDownBrokerGracefullyParameters = BrokersBaseShutDownBrokerGracefullyParameters
  { brokersBaseShutDownBrokerGracefullyMaxConcurrentUnloadPerSec :: Maybe Int -- ^ if the value absent(value=0) means no concurrent limitation.
  , brokersBaseShutDownBrokerGracefullyForcedTerminateTopic :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

brokersBaseShutDownBrokerGracefully :: BrokersBaseShutDownBrokerGracefullyParameters -> ClientM NoContent
brokersBaseShutDownBrokerGracefully BrokersBaseShutDownBrokerGracefullyParameters {..} = client (Proxy :: Proxy BrokersBaseShutDownBrokerGracefullyAPI) (brokersBaseShutDownBrokerGracefullyMaxConcurrentUnloadPerSec) (brokersBaseShutDownBrokerGracefullyForcedTerminateTopic)

-- ^ 
type BrokersBaseUpdateDynamicConfigurationAPI =
      "admin" :> "v2" :> "brokers" :> "configuration" :> Capture "configName" Text :> Capture "configValue" Text :> Verb 'POST 200 '[JSON] NoContent

data BrokersBaseUpdateDynamicConfigurationParameters = BrokersBaseUpdateDynamicConfigurationParameters
  { brokersBaseUpdateDynamicConfigurationConfigName :: Text -- ^ 
  , brokersBaseUpdateDynamicConfigurationConfigValue :: Text -- ^ 
  } deriving (Show, Eq, Generic)

brokersBaseUpdateDynamicConfiguration :: BrokersBaseUpdateDynamicConfigurationParameters -> ClientM NoContent
brokersBaseUpdateDynamicConfiguration BrokersBaseUpdateDynamicConfigurationParameters {..} = client (Proxy :: Proxy BrokersBaseUpdateDynamicConfigurationAPI) (brokersBaseUpdateDynamicConfigurationConfigName) (brokersBaseUpdateDynamicConfigurationConfigValue)

-- ^ 
type BrokersBaseVersionAPI =
      "admin" :> "v2" :> "brokers" :> "version" :> Verb 'GET 200 '[JSON] Text

brokersBaseVersion :: ClientM Text
brokersBaseVersion = client (Proxy :: Proxy BrokersBaseVersionAPI)

-- ^ This operation requires Pulsar superuser privileges, and the name cannot contain the '/' characters.
type ClustersBaseCreateClusterAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> ReqBody '[JSON] ClusterData :> Verb 'PUT 200 '[JSON] NoContent

data ClustersBaseCreateClusterParameters = ClustersBaseCreateClusterParameters
  { clustersBaseCreateClusterCluster :: Text -- ^ The cluster name
  , clustersBaseCreateClusterBody :: ClusterData -- ^ The cluster data
  } deriving (Show, Eq, Generic)

clustersBaseCreateCluster :: ClustersBaseCreateClusterParameters -> ClientM NoContent
clustersBaseCreateCluster ClustersBaseCreateClusterParameters {..} = client (Proxy :: Proxy ClustersBaseCreateClusterAPI) (clustersBaseCreateClusterCluster) clustersBaseCreateClusterBody

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseDeleteClusterAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> Verb 'DELETE 200 '[JSON] NoContent

data ClustersBaseDeleteClusterParameters = ClustersBaseDeleteClusterParameters
  { clustersBaseDeleteClusterCluster :: Text -- ^ The cluster name
  } deriving (Show, Eq, Generic)

clustersBaseDeleteCluster :: ClustersBaseDeleteClusterParameters -> ClientM NoContent
clustersBaseDeleteCluster ClustersBaseDeleteClusterParameters {..} = client (Proxy :: Proxy ClustersBaseDeleteClusterAPI) (clustersBaseDeleteClusterCluster)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseDeleteFailureDomainAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "failureDomains" :> Capture "domainName" Text :> Verb 'DELETE 200 '[JSON] NoContent

data ClustersBaseDeleteFailureDomainParameters = ClustersBaseDeleteFailureDomainParameters
  { clustersBaseDeleteFailureDomainCluster :: Text -- ^ The cluster name
  , clustersBaseDeleteFailureDomainDomainName :: Text -- ^ The failure domain name
  } deriving (Show, Eq, Generic)

clustersBaseDeleteFailureDomain :: ClustersBaseDeleteFailureDomainParameters -> ClientM NoContent
clustersBaseDeleteFailureDomain ClustersBaseDeleteFailureDomainParameters {..} = client (Proxy :: Proxy ClustersBaseDeleteFailureDomainAPI) (clustersBaseDeleteFailureDomainCluster) (clustersBaseDeleteFailureDomainDomainName)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseDeleteNamespaceIsolationPolicyAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "namespaceIsolationPolicies" :> Capture "policyName" Text :> Verb 'DELETE 200 '[JSON] NoContent

data ClustersBaseDeleteNamespaceIsolationPolicyParameters = ClustersBaseDeleteNamespaceIsolationPolicyParameters
  { clustersBaseDeleteNamespaceIsolationPolicyCluster :: Text -- ^ The cluster name
  , clustersBaseDeleteNamespaceIsolationPolicyPolicyName :: Text -- ^ The namespace isolation policy name
  } deriving (Show, Eq, Generic)

clustersBaseDeleteNamespaceIsolationPolicy :: ClustersBaseDeleteNamespaceIsolationPolicyParameters -> ClientM NoContent
clustersBaseDeleteNamespaceIsolationPolicy ClustersBaseDeleteNamespaceIsolationPolicyParameters {..} = client (Proxy :: Proxy ClustersBaseDeleteNamespaceIsolationPolicyAPI) (clustersBaseDeleteNamespaceIsolationPolicyCluster) (clustersBaseDeleteNamespaceIsolationPolicyPolicyName)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseGetBrokerWithNamespaceIsolationPolicyAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "namespaceIsolationPolicies" :> "brokers" :> Capture "broker" Text :> Verb 'GET 200 '[JSON] BrokerNamespaceIsolationData

data ClustersBaseGetBrokerWithNamespaceIsolationPolicyParameters = ClustersBaseGetBrokerWithNamespaceIsolationPolicyParameters
  { clustersBaseGetBrokerWithNamespaceIsolationPolicyCluster :: Text -- ^ The cluster name
  , clustersBaseGetBrokerWithNamespaceIsolationPolicyBroker :: Text -- ^ The broker name (<broker-hostname>:<web-service-port>)
  } deriving (Show, Eq, Generic)

clustersBaseGetBrokerWithNamespaceIsolationPolicy :: ClustersBaseGetBrokerWithNamespaceIsolationPolicyParameters -> ClientM BrokerNamespaceIsolationData
clustersBaseGetBrokerWithNamespaceIsolationPolicy ClustersBaseGetBrokerWithNamespaceIsolationPolicyParameters {..} = client (Proxy :: Proxy ClustersBaseGetBrokerWithNamespaceIsolationPolicyAPI) (clustersBaseGetBrokerWithNamespaceIsolationPolicyCluster) (clustersBaseGetBrokerWithNamespaceIsolationPolicyBroker)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseGetBrokersWithNamespaceIsolationPolicyAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "namespaceIsolationPolicies" :> "brokers" :> Verb 'GET 200 '[JSON] [BrokerNamespaceIsolationData]

data ClustersBaseGetBrokersWithNamespaceIsolationPolicyParameters = ClustersBaseGetBrokersWithNamespaceIsolationPolicyParameters
  { clustersBaseGetBrokersWithNamespaceIsolationPolicyCluster :: Text -- ^ The cluster name
  } deriving (Show, Eq, Generic)

clustersBaseGetBrokersWithNamespaceIsolationPolicy :: ClustersBaseGetBrokersWithNamespaceIsolationPolicyParameters -> ClientM [BrokerNamespaceIsolationData]
clustersBaseGetBrokersWithNamespaceIsolationPolicy ClustersBaseGetBrokersWithNamespaceIsolationPolicyParameters {..} = client (Proxy :: Proxy ClustersBaseGetBrokersWithNamespaceIsolationPolicyAPI) (clustersBaseGetBrokersWithNamespaceIsolationPolicyCluster)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseGetClusterAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> Verb 'GET 200 '[JSON] ClusterData

data ClustersBaseGetClusterParameters = ClustersBaseGetClusterParameters
  { clustersBaseGetClusterCluster :: Text -- ^ The cluster name
  } deriving (Show, Eq, Generic)

clustersBaseGetCluster :: ClustersBaseGetClusterParameters -> ClientM ClusterData
clustersBaseGetCluster ClustersBaseGetClusterParameters {..} = client (Proxy :: Proxy ClustersBaseGetClusterAPI) (clustersBaseGetClusterCluster)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseGetClusterMigrationAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "migrate" :> Verb 'GET 200 '[JSON] ClusterData

data ClustersBaseGetClusterMigrationParameters = ClustersBaseGetClusterMigrationParameters
  { clustersBaseGetClusterMigrationCluster :: Text -- ^ The cluster name
  } deriving (Show, Eq, Generic)

clustersBaseGetClusterMigration :: ClustersBaseGetClusterMigrationParameters -> ClientM ClusterData
clustersBaseGetClusterMigration ClustersBaseGetClusterMigrationParameters {..} = client (Proxy :: Proxy ClustersBaseGetClusterMigrationAPI) (clustersBaseGetClusterMigrationCluster)

-- ^ 
type ClustersBaseGetClustersAPI =
      "admin" :> "v2" :> "clusters" :> Verb 'GET 200 '[JSON] [Text]

clustersBaseGetClusters :: ClientM [Text]
clustersBaseGetClusters = client (Proxy :: Proxy ClustersBaseGetClustersAPI)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseGetDomainAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "failureDomains" :> Capture "domainName" Text :> Verb 'GET 200 '[JSON] FailureDomain

data ClustersBaseGetDomainParameters = ClustersBaseGetDomainParameters
  { clustersBaseGetDomainCluster :: Text -- ^ The cluster name
  , clustersBaseGetDomainDomainName :: Text -- ^ The failure domain name
  } deriving (Show, Eq, Generic)

clustersBaseGetDomain :: ClustersBaseGetDomainParameters -> ClientM FailureDomain
clustersBaseGetDomain ClustersBaseGetDomainParameters {..} = client (Proxy :: Proxy ClustersBaseGetDomainAPI) (clustersBaseGetDomainCluster) (clustersBaseGetDomainDomainName)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseGetFailureDomainsAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "failureDomains" :> Verb 'GET 200 '[JSON] ((Map.Map String FailureDomain))

data ClustersBaseGetFailureDomainsParameters = ClustersBaseGetFailureDomainsParameters
  { clustersBaseGetFailureDomainsCluster :: Text -- ^ The cluster name
  } deriving (Show, Eq, Generic)

clustersBaseGetFailureDomains :: ClustersBaseGetFailureDomainsParameters -> ClientM (Map.Map String FailureDomain)
clustersBaseGetFailureDomains ClustersBaseGetFailureDomainsParameters {..} = client (Proxy :: Proxy ClustersBaseGetFailureDomainsAPI) (clustersBaseGetFailureDomainsCluster)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseGetNamespaceIsolationPoliciesAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "namespaceIsolationPolicies" :> Verb 'GET 200 '[JSON] ((Map.Map String NamespaceIsolationData))

data ClustersBaseGetNamespaceIsolationPoliciesParameters = ClustersBaseGetNamespaceIsolationPoliciesParameters
  { clustersBaseGetNamespaceIsolationPoliciesCluster :: Text -- ^ The cluster name
  } deriving (Show, Eq, Generic)

clustersBaseGetNamespaceIsolationPolicies :: ClustersBaseGetNamespaceIsolationPoliciesParameters -> ClientM (Map.Map String NamespaceIsolationData)
clustersBaseGetNamespaceIsolationPolicies ClustersBaseGetNamespaceIsolationPoliciesParameters {..} = client (Proxy :: Proxy ClustersBaseGetNamespaceIsolationPoliciesAPI) (clustersBaseGetNamespaceIsolationPoliciesCluster)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseGetNamespaceIsolationPolicyAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "namespaceIsolationPolicies" :> Capture "policyName" Text :> Verb 'GET 200 '[JSON] NamespaceIsolationData

data ClustersBaseGetNamespaceIsolationPolicyParameters = ClustersBaseGetNamespaceIsolationPolicyParameters
  { clustersBaseGetNamespaceIsolationPolicyCluster :: Text -- ^ The cluster name
  , clustersBaseGetNamespaceIsolationPolicyPolicyName :: Text -- ^ The name of the namespace isolation policy
  } deriving (Show, Eq, Generic)

clustersBaseGetNamespaceIsolationPolicy :: ClustersBaseGetNamespaceIsolationPolicyParameters -> ClientM NamespaceIsolationData
clustersBaseGetNamespaceIsolationPolicy ClustersBaseGetNamespaceIsolationPolicyParameters {..} = client (Proxy :: Proxy ClustersBaseGetNamespaceIsolationPolicyAPI) (clustersBaseGetNamespaceIsolationPolicyCluster) (clustersBaseGetNamespaceIsolationPolicyPolicyName)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseGetPeerClusterAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "peers" :> Verb 'GET 200 '[JSON] [Text]

data ClustersBaseGetPeerClusterParameters = ClustersBaseGetPeerClusterParameters
  { clustersBaseGetPeerClusterCluster :: Text -- ^ The cluster name
  } deriving (Show, Eq, Generic)

clustersBaseGetPeerCluster :: ClustersBaseGetPeerClusterParameters -> ClientM [Text]
clustersBaseGetPeerCluster ClustersBaseGetPeerClusterParameters {..} = client (Proxy :: Proxy ClustersBaseGetPeerClusterAPI) (clustersBaseGetPeerClusterCluster)

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseSetFailureDomainAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "failureDomains" :> Capture "domainName" Text :> ReqBody '[JSON] FailureDomain :> Verb 'POST 200 '[JSON] NoContent

data ClustersBaseSetFailureDomainParameters = ClustersBaseSetFailureDomainParameters
  { clustersBaseSetFailureDomainCluster :: Text -- ^ The cluster name
  , clustersBaseSetFailureDomainDomainName :: Text -- ^ The failure domain name
  , clustersBaseSetFailureDomainBody :: FailureDomain -- ^ The configuration data of a failure domain
  } deriving (Show, Eq, Generic)

clustersBaseSetFailureDomain :: ClustersBaseSetFailureDomainParameters -> ClientM NoContent
clustersBaseSetFailureDomain ClustersBaseSetFailureDomainParameters {..} = client (Proxy :: Proxy ClustersBaseSetFailureDomainAPI) (clustersBaseSetFailureDomainCluster) (clustersBaseSetFailureDomainDomainName) clustersBaseSetFailureDomainBody

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseSetNamespaceIsolationPolicyAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "namespaceIsolationPolicies" :> Capture "policyName" Text :> ReqBody '[JSON] NamespaceIsolationData :> Verb 'POST 200 '[JSON] NoContent

data ClustersBaseSetNamespaceIsolationPolicyParameters = ClustersBaseSetNamespaceIsolationPolicyParameters
  { clustersBaseSetNamespaceIsolationPolicyCluster :: Text -- ^ The cluster name
  , clustersBaseSetNamespaceIsolationPolicyPolicyName :: Text -- ^ The namespace isolation policy name
  , clustersBaseSetNamespaceIsolationPolicyBody :: NamespaceIsolationData -- ^ The namespace isolation policy data
  } deriving (Show, Eq, Generic)

clustersBaseSetNamespaceIsolationPolicy :: ClustersBaseSetNamespaceIsolationPolicyParameters -> ClientM NoContent
clustersBaseSetNamespaceIsolationPolicy ClustersBaseSetNamespaceIsolationPolicyParameters {..} = client (Proxy :: Proxy ClustersBaseSetNamespaceIsolationPolicyAPI) (clustersBaseSetNamespaceIsolationPolicyCluster) (clustersBaseSetNamespaceIsolationPolicyPolicyName) clustersBaseSetNamespaceIsolationPolicyBody

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseSetPeerClusterNamesAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "peers" :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data ClustersBaseSetPeerClusterNamesParameters = ClustersBaseSetPeerClusterNamesParameters
  { clustersBaseSetPeerClusterNamesCluster :: Text -- ^ The cluster name
  , clustersBaseSetPeerClusterNamesBody :: [Text] -- ^ The list of peer cluster names
  } deriving (Show, Eq, Generic)

clustersBaseSetPeerClusterNames :: ClustersBaseSetPeerClusterNamesParameters -> ClientM NoContent
clustersBaseSetPeerClusterNames ClustersBaseSetPeerClusterNamesParameters {..} = client (Proxy :: Proxy ClustersBaseSetPeerClusterNamesAPI) (clustersBaseSetPeerClusterNamesCluster) clustersBaseSetPeerClusterNamesBody

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseUpdateClusterAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> ReqBody '[JSON] ClusterData :> Verb 'POST 200 '[JSON] NoContent

data ClustersBaseUpdateClusterParameters = ClustersBaseUpdateClusterParameters
  { clustersBaseUpdateClusterCluster :: Text -- ^ The cluster name
  , clustersBaseUpdateClusterBody :: ClusterData -- ^ The cluster data
  } deriving (Show, Eq, Generic)

clustersBaseUpdateCluster :: ClustersBaseUpdateClusterParameters -> ClientM NoContent
clustersBaseUpdateCluster ClustersBaseUpdateClusterParameters {..} = client (Proxy :: Proxy ClustersBaseUpdateClusterAPI) (clustersBaseUpdateClusterCluster) clustersBaseUpdateClusterBody

-- ^ This operation requires Pulsar superuser privileges.
type ClustersBaseUpdateClusterMigrationAPI =
      "admin" :> "v2" :> "clusters" :> Capture "cluster" Text :> "migrate" :> QueryParam "migrated" Bool :> ReqBody '[JSON] ClusterUrl :> Verb 'POST 200 '[JSON] NoContent

data ClustersBaseUpdateClusterMigrationParameters = ClustersBaseUpdateClusterMigrationParameters
  { clustersBaseUpdateClusterMigrationCluster :: Text -- ^ The cluster name
  , clustersBaseUpdateClusterMigrationMigrated :: Bool -- ^ Is cluster migrated
  , clustersBaseUpdateClusterMigrationBody :: ClusterUrl -- ^ The cluster url data
  } deriving (Show, Eq, Generic)

clustersBaseUpdateClusterMigration :: ClustersBaseUpdateClusterMigrationParameters -> ClientM NoContent
clustersBaseUpdateClusterMigration ClustersBaseUpdateClusterMigrationParameters {..} = client (Proxy :: Proxy ClustersBaseUpdateClusterMigrationAPI) (clustersBaseUpdateClusterMigrationCluster) (Just clustersBaseUpdateClusterMigrationMigrated) clustersBaseUpdateClusterMigrationBody

-- ^ 
type WorkerDrainAPI =
      "admin" :> "v2" :> "worker" :> "drain" :> Verb 'PUT 200 '[JSON] NoContent

workerDrain :: ClientM NoContent
workerDrain = client (Proxy :: Proxy WorkerDrainAPI)

-- ^ 
type WorkerDrainAtLeaderAPI =
      "admin" :> "v2" :> "worker" :> "leader" :> "drain" :> QueryParam "workerId" Text :> Verb 'PUT 200 '[JSON] NoContent

data WorkerDrainAtLeaderParameters = WorkerDrainAtLeaderParameters
  { workerDrainAtLeaderWorkerId :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

workerDrainAtLeader :: WorkerDrainAtLeaderParameters -> ClientM NoContent
workerDrainAtLeader WorkerDrainAtLeaderParameters {..} = client (Proxy :: Proxy WorkerDrainAtLeaderAPI) (workerDrainAtLeaderWorkerId)

-- ^ Returns a nested map structure which Swagger does not fully support for display.Structure: Map<String, Set<String>>. Please refer to this structure for details.
type WorkerGetAssignmentsAPI =
      "admin" :> "v2" :> "worker" :> "assignments" :> Verb 'GET 200 '[JSON] ((Map.Map String Value))

workerGetAssignments :: ClientM (Map.Map String Value)
workerGetAssignments = client (Proxy :: Proxy WorkerGetAssignmentsAPI)

-- ^ 
type WorkerGetClusterAPI =
      "admin" :> "v2" :> "worker" :> "cluster" :> Verb 'GET 200 '[JSON] [WorkerInfo]

workerGetCluster :: ClientM [WorkerInfo]
workerGetCluster = client (Proxy :: Proxy WorkerGetClusterAPI)

-- ^ 
type WorkerGetClusterLeaderAPI =
      "admin" :> "v2" :> "worker" :> "cluster" :> "leader" :> Verb 'GET 200 '[JSON] WorkerInfo

workerGetClusterLeader :: ClientM WorkerInfo
workerGetClusterLeader = client (Proxy :: Proxy WorkerGetClusterLeaderAPI)

-- ^ 
type WorkerGetConnectorsListAPI =
      "admin" :> "v2" :> "worker" :> "connectors" :> Verb 'GET 200 '[JSON] [ConnectorDefinition]

workerGetConnectorsList :: ClientM [ConnectorDefinition]
workerGetConnectorsList = client (Proxy :: Proxy WorkerGetConnectorsListAPI)

-- ^ 
type WorkerGetDrainStatusAPI =
      "admin" :> "v2" :> "worker" :> "drain" :> Verb 'GET 200 '[JSON] LongRunningProcessStatus

workerGetDrainStatus :: ClientM LongRunningProcessStatus
workerGetDrainStatus = client (Proxy :: Proxy WorkerGetDrainStatusAPI)

-- ^ 
type WorkerGetDrainStatusFromLeaderAPI =
      "admin" :> "v2" :> "worker" :> "leader" :> "drain" :> QueryParam "workerId" Text :> Verb 'GET 200 '[JSON] LongRunningProcessStatus

data WorkerGetDrainStatusFromLeaderParameters = WorkerGetDrainStatusFromLeaderParameters
  { workerGetDrainStatusFromLeaderWorkerId :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

workerGetDrainStatusFromLeader :: WorkerGetDrainStatusFromLeaderParameters -> ClientM LongRunningProcessStatus
workerGetDrainStatusFromLeader WorkerGetDrainStatusFromLeaderParameters {..} = client (Proxy :: Proxy WorkerGetDrainStatusFromLeaderAPI) (workerGetDrainStatusFromLeaderWorkerId)

-- ^ 
type WorkerIsLeaderReadyAPI =
      "admin" :> "v2" :> "worker" :> "cluster" :> "leader" :> "ready" :> Verb 'GET 200 '[JSON] Bool

workerIsLeaderReady :: ClientM Bool
workerIsLeaderReady = client (Proxy :: Proxy WorkerIsLeaderReadyAPI)

-- ^ 
type WorkerRebalanceAPI =
      "admin" :> "v2" :> "worker" :> "rebalance" :> Verb 'PUT 200 '[JSON] NoContent

workerRebalance :: ClientM NoContent
workerRebalance = client (Proxy :: Proxy WorkerRebalanceAPI)

-- ^ Request should be executed by Monitoring agent on each worker to fetch the worker-metrics
type WorkerStatsGetMetricsAPI =
      "admin" :> "v2" :> "worker-stats" :> "metrics" :> Verb 'GET 200 '[JSON] [Metrics]

workerStatsGetMetrics :: ClientM [Metrics]
workerStatsGetMetrics = client (Proxy :: Proxy WorkerStatsGetMetricsAPI)

-- ^ Requested should be executed by Monitoring agent on each worker to fetch the metrics
type WorkerStatsGetStatsAPI =
      "admin" :> "v2" :> "worker-stats" :> "functionsmetrics" :> Verb 'GET 200 '[JSON] [WorkerFunctionInstanceStats]

workerStatsGetStats :: ClientM [WorkerFunctionInstanceStats]
workerStatsGetStats = client (Proxy :: Proxy WorkerStatsGetStatsAPI)

-- ^ 
type NamespacesClearNamespaceBacklogAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "clearBacklog" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesClearNamespaceBacklogParameters = NamespacesClearNamespaceBacklogParameters
  { namespacesClearNamespaceBacklogTenant :: Text -- ^ 
  , namespacesClearNamespaceBacklogNamespace :: Text -- ^ 
  , namespacesClearNamespaceBacklogAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

namespacesClearNamespaceBacklog :: NamespacesClearNamespaceBacklogParameters -> ClientM NoContent
namespacesClearNamespaceBacklog NamespacesClearNamespaceBacklogParameters {..} = client (Proxy :: Proxy NamespacesClearNamespaceBacklogAPI) (namespacesClearNamespaceBacklogTenant) (namespacesClearNamespaceBacklogNamespace) (namespacesClearNamespaceBacklogAuthoritative)

-- ^ 
type NamespacesClearNamespaceBacklogForSubscriptionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "clearBacklog" :> Capture "subscription" Text :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesClearNamespaceBacklogForSubscriptionParameters = NamespacesClearNamespaceBacklogForSubscriptionParameters
  { namespacesClearNamespaceBacklogForSubscriptionTenant :: Text -- ^ 
  , namespacesClearNamespaceBacklogForSubscriptionNamespace :: Text -- ^ 
  , namespacesClearNamespaceBacklogForSubscriptionSubscription :: Text -- ^ 
  , namespacesClearNamespaceBacklogForSubscriptionAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

namespacesClearNamespaceBacklogForSubscription :: NamespacesClearNamespaceBacklogForSubscriptionParameters -> ClientM NoContent
namespacesClearNamespaceBacklogForSubscription NamespacesClearNamespaceBacklogForSubscriptionParameters {..} = client (Proxy :: Proxy NamespacesClearNamespaceBacklogForSubscriptionAPI) (namespacesClearNamespaceBacklogForSubscriptionTenant) (namespacesClearNamespaceBacklogForSubscriptionNamespace) (namespacesClearNamespaceBacklogForSubscriptionSubscription) (namespacesClearNamespaceBacklogForSubscriptionAuthoritative)

-- ^ 
type NamespacesClearNamespaceBundleBacklogAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> "clearBacklog" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesClearNamespaceBundleBacklogParameters = NamespacesClearNamespaceBundleBacklogParameters
  { namespacesClearNamespaceBundleBacklogTenant :: Text -- ^ 
  , namespacesClearNamespaceBundleBacklogNamespace :: Text -- ^ 
  , namespacesClearNamespaceBundleBacklogBundle :: Text -- ^ 
  , namespacesClearNamespaceBundleBacklogAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

namespacesClearNamespaceBundleBacklog :: NamespacesClearNamespaceBundleBacklogParameters -> ClientM NoContent
namespacesClearNamespaceBundleBacklog NamespacesClearNamespaceBundleBacklogParameters {..} = client (Proxy :: Proxy NamespacesClearNamespaceBundleBacklogAPI) (namespacesClearNamespaceBundleBacklogTenant) (namespacesClearNamespaceBundleBacklogNamespace) (namespacesClearNamespaceBundleBacklogBundle) (namespacesClearNamespaceBundleBacklogAuthoritative)

-- ^ 
type NamespacesClearNamespaceBundleBacklogForSubscriptionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> "clearBacklog" :> Capture "subscription" Text :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesClearNamespaceBundleBacklogForSubscriptionParameters = NamespacesClearNamespaceBundleBacklogForSubscriptionParameters
  { namespacesClearNamespaceBundleBacklogForSubscriptionTenant :: Text -- ^ 
  , namespacesClearNamespaceBundleBacklogForSubscriptionNamespace :: Text -- ^ 
  , namespacesClearNamespaceBundleBacklogForSubscriptionSubscription :: Text -- ^ 
  , namespacesClearNamespaceBundleBacklogForSubscriptionBundle :: Text -- ^ 
  , namespacesClearNamespaceBundleBacklogForSubscriptionAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

namespacesClearNamespaceBundleBacklogForSubscription :: NamespacesClearNamespaceBundleBacklogForSubscriptionParameters -> ClientM NoContent
namespacesClearNamespaceBundleBacklogForSubscription NamespacesClearNamespaceBundleBacklogForSubscriptionParameters {..} = client (Proxy :: Proxy NamespacesClearNamespaceBundleBacklogForSubscriptionAPI) (namespacesClearNamespaceBundleBacklogForSubscriptionTenant) (namespacesClearNamespaceBundleBacklogForSubscriptionNamespace) (namespacesClearNamespaceBundleBacklogForSubscriptionSubscription) (namespacesClearNamespaceBundleBacklogForSubscriptionBundle) (namespacesClearNamespaceBundleBacklogForSubscriptionAuthoritative)

-- ^ 
type NamespacesClearOffloadDeletionLagAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "offloadDeletionLagMs" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesClearOffloadDeletionLagParameters = NamespacesClearOffloadDeletionLagParameters
  { namespacesClearOffloadDeletionLagTenant :: Text -- ^ 
  , namespacesClearOffloadDeletionLagNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesClearOffloadDeletionLag :: NamespacesClearOffloadDeletionLagParameters -> ClientM NoContent
namespacesClearOffloadDeletionLag NamespacesClearOffloadDeletionLagParameters {..} = client (Proxy :: Proxy NamespacesClearOffloadDeletionLagAPI) (namespacesClearOffloadDeletionLagTenant) (namespacesClearOffloadDeletionLagNamespace)

-- ^ 
type NamespacesClearPropertiesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "properties" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesClearPropertiesParameters = NamespacesClearPropertiesParameters
  { namespacesClearPropertiesTenant :: Text -- ^ 
  , namespacesClearPropertiesNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesClearProperties :: NamespacesClearPropertiesParameters -> ClientM NoContent
namespacesClearProperties NamespacesClearPropertiesParameters {..} = client (Proxy :: Proxy NamespacesClearPropertiesAPI) (namespacesClearPropertiesTenant) (namespacesClearPropertiesNamespace)

-- ^ 
type NamespacesCreateNamespaceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> ReqBody '[JSON] Policies :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesCreateNamespaceParameters = NamespacesCreateNamespaceParameters
  { namespacesCreateNamespaceTenant :: Text -- ^ 
  , namespacesCreateNamespaceNamespace :: Text -- ^ 
  , namespacesCreateNamespaceBody :: Policies -- ^ Policies for the namespace
  } deriving (Show, Eq, Generic)

namespacesCreateNamespace :: NamespacesCreateNamespaceParameters -> ClientM NoContent
namespacesCreateNamespace NamespacesCreateNamespaceParameters {..} = client (Proxy :: Proxy NamespacesCreateNamespaceAPI) (namespacesCreateNamespaceTenant) (namespacesCreateNamespaceNamespace) namespacesCreateNamespaceBody

-- ^ 
type NamespacesDeleteBookieAffinityGroupAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "property" Text :> Capture "namespace" Text :> "persistence" :> "bookieAffinity" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesDeleteBookieAffinityGroupParameters = NamespacesDeleteBookieAffinityGroupParameters
  { namespacesDeleteBookieAffinityGroupProperty :: Text -- ^ 
  , namespacesDeleteBookieAffinityGroupNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesDeleteBookieAffinityGroup :: NamespacesDeleteBookieAffinityGroupParameters -> ClientM NoContent
namespacesDeleteBookieAffinityGroup NamespacesDeleteBookieAffinityGroupParameters {..} = client (Proxy :: Proxy NamespacesDeleteBookieAffinityGroupAPI) (namespacesDeleteBookieAffinityGroupProperty) (namespacesDeleteBookieAffinityGroupNamespace)

-- ^ The backlog size is compared to the threshold periodically. A threshold of 0 disabled automatic compaction
type NamespacesDeleteCompactionThresholdAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "compactionThreshold" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesDeleteCompactionThresholdParameters = NamespacesDeleteCompactionThresholdParameters
  { namespacesDeleteCompactionThresholdTenant :: Text -- ^ 
  , namespacesDeleteCompactionThresholdNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesDeleteCompactionThreshold :: NamespacesDeleteCompactionThresholdParameters -> ClientM NoContent
namespacesDeleteCompactionThreshold NamespacesDeleteCompactionThresholdParameters {..} = client (Proxy :: Proxy NamespacesDeleteCompactionThresholdAPI) (namespacesDeleteCompactionThresholdTenant) (namespacesDeleteCompactionThresholdNamespace)

-- ^ 
type NamespacesDeleteDispatchRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "dispatchRate" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesDeleteDispatchRateParameters = NamespacesDeleteDispatchRateParameters
  { namespacesDeleteDispatchRateTenant :: Text -- ^ 
  , namespacesDeleteDispatchRateNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesDeleteDispatchRate :: NamespacesDeleteDispatchRateParameters -> ClientM NoContent
namespacesDeleteDispatchRate NamespacesDeleteDispatchRateParameters {..} = client (Proxy :: Proxy NamespacesDeleteDispatchRateAPI) (namespacesDeleteDispatchRateTenant) (namespacesDeleteDispatchRateNamespace)

-- ^ 
type NamespacesDeleteNamespaceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> QueryParam "force" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesDeleteNamespaceParameters = NamespacesDeleteNamespaceParameters
  { namespacesDeleteNamespaceTenant :: Text -- ^ 
  , namespacesDeleteNamespaceNamespace :: Text -- ^ 
  , namespacesDeleteNamespaceForce :: Maybe Bool -- ^ 
  , namespacesDeleteNamespaceAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

namespacesDeleteNamespace :: NamespacesDeleteNamespaceParameters -> ClientM NoContent
namespacesDeleteNamespace NamespacesDeleteNamespaceParameters {..} = client (Proxy :: Proxy NamespacesDeleteNamespaceAPI) (namespacesDeleteNamespaceTenant) (namespacesDeleteNamespaceNamespace) (namespacesDeleteNamespaceForce) (namespacesDeleteNamespaceAuthoritative)

-- ^ 
type NamespacesDeleteNamespaceBundleAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> QueryParam "force" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesDeleteNamespaceBundleParameters = NamespacesDeleteNamespaceBundleParameters
  { namespacesDeleteNamespaceBundleTenant :: Text -- ^ 
  , namespacesDeleteNamespaceBundleNamespace :: Text -- ^ 
  , namespacesDeleteNamespaceBundleBundle :: Text -- ^ 
  , namespacesDeleteNamespaceBundleForce :: Maybe Bool -- ^ 
  , namespacesDeleteNamespaceBundleAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

namespacesDeleteNamespaceBundle :: NamespacesDeleteNamespaceBundleParameters -> ClientM NoContent
namespacesDeleteNamespaceBundle NamespacesDeleteNamespaceBundleParameters {..} = client (Proxy :: Proxy NamespacesDeleteNamespaceBundleAPI) (namespacesDeleteNamespaceBundleTenant) (namespacesDeleteNamespaceBundleNamespace) (namespacesDeleteNamespaceBundleBundle) (namespacesDeleteNamespaceBundleForce) (namespacesDeleteNamespaceBundleAuthoritative)

-- ^ 
type NamespacesDeletePersistenceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "persistence" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesDeletePersistenceParameters = NamespacesDeletePersistenceParameters
  { namespacesDeletePersistenceTenant :: Text -- ^ 
  , namespacesDeletePersistenceNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesDeletePersistence :: NamespacesDeletePersistenceParameters -> ClientM NoContent
namespacesDeletePersistence NamespacesDeletePersistenceParameters {..} = client (Proxy :: Proxy NamespacesDeletePersistenceAPI) (namespacesDeletePersistenceTenant) (namespacesDeletePersistenceNamespace)

-- ^ 
type NamespacesDeleteSubscribeRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscribeRate" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesDeleteSubscribeRateParameters = NamespacesDeleteSubscribeRateParameters
  { namespacesDeleteSubscribeRateTenant :: Text -- ^ 
  , namespacesDeleteSubscribeRateNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesDeleteSubscribeRate :: NamespacesDeleteSubscribeRateParameters -> ClientM NoContent
namespacesDeleteSubscribeRate NamespacesDeleteSubscribeRateParameters {..} = client (Proxy :: Proxy NamespacesDeleteSubscribeRateAPI) (namespacesDeleteSubscribeRateTenant) (namespacesDeleteSubscribeRateNamespace)

-- ^ 
type NamespacesDeleteSubscriptionDispatchRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionDispatchRate" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesDeleteSubscriptionDispatchRateParameters = NamespacesDeleteSubscriptionDispatchRateParameters
  { namespacesDeleteSubscriptionDispatchRateTenant :: Text -- ^ 
  , namespacesDeleteSubscriptionDispatchRateNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesDeleteSubscriptionDispatchRate :: NamespacesDeleteSubscriptionDispatchRateParameters -> ClientM NoContent
namespacesDeleteSubscriptionDispatchRate NamespacesDeleteSubscriptionDispatchRateParameters {..} = client (Proxy :: Proxy NamespacesDeleteSubscriptionDispatchRateAPI) (namespacesDeleteSubscriptionDispatchRateTenant) (namespacesDeleteSubscriptionDispatchRateNamespace)

-- ^ 
type NamespacesGetAntiAffinityNamespacesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "cluster" Text :> "antiAffinity" :> Capture "group" Text :> QueryParam "tenant" Text :> Verb 'GET 200 '[JSON] [Text]

data NamespacesGetAntiAffinityNamespacesParameters = NamespacesGetAntiAffinityNamespacesParameters
  { namespacesGetAntiAffinityNamespacesCluster :: Text -- ^ 
  , namespacesGetAntiAffinityNamespacesGroup :: Text -- ^ 
  , namespacesGetAntiAffinityNamespacesTenant :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetAntiAffinityNamespaces :: NamespacesGetAntiAffinityNamespacesParameters -> ClientM [Text]
namespacesGetAntiAffinityNamespaces NamespacesGetAntiAffinityNamespacesParameters {..} = client (Proxy :: Proxy NamespacesGetAntiAffinityNamespacesAPI) (namespacesGetAntiAffinityNamespacesCluster) (namespacesGetAntiAffinityNamespacesGroup) (namespacesGetAntiAffinityNamespacesTenant)

-- ^ 
type NamespacesGetAutoSubscriptionCreationAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "autoSubscriptionCreation" :> Verb 'GET 200 '[JSON] AutoSubscriptionCreationOverrideImpl

data NamespacesGetAutoSubscriptionCreationParameters = NamespacesGetAutoSubscriptionCreationParameters
  { namespacesGetAutoSubscriptionCreationTenant :: Text -- ^ 
  , namespacesGetAutoSubscriptionCreationNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetAutoSubscriptionCreation :: NamespacesGetAutoSubscriptionCreationParameters -> ClientM AutoSubscriptionCreationOverrideImpl
namespacesGetAutoSubscriptionCreation NamespacesGetAutoSubscriptionCreationParameters {..} = client (Proxy :: Proxy NamespacesGetAutoSubscriptionCreationAPI) (namespacesGetAutoSubscriptionCreationTenant) (namespacesGetAutoSubscriptionCreationNamespace)

-- ^ 
type NamespacesGetAutoTopicCreationAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "autoTopicCreation" :> Verb 'GET 200 '[JSON] AutoTopicCreationOverrideImpl

data NamespacesGetAutoTopicCreationParameters = NamespacesGetAutoTopicCreationParameters
  { namespacesGetAutoTopicCreationTenant :: Text -- ^ 
  , namespacesGetAutoTopicCreationNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetAutoTopicCreation :: NamespacesGetAutoTopicCreationParameters -> ClientM AutoTopicCreationOverrideImpl
namespacesGetAutoTopicCreation NamespacesGetAutoTopicCreationParameters {..} = client (Proxy :: Proxy NamespacesGetAutoTopicCreationAPI) (namespacesGetAutoTopicCreationTenant) (namespacesGetAutoTopicCreationNamespace)

-- ^ 
type NamespacesGetBacklogQuotaMapAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "backlogQuotaMap" :> Verb 'GET 200 '[JSON] ((Map.Map String BacklogQuotaImpl))

data NamespacesGetBacklogQuotaMapParameters = NamespacesGetBacklogQuotaMapParameters
  { namespacesGetBacklogQuotaMapTenant :: Text -- ^ 
  , namespacesGetBacklogQuotaMapNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetBacklogQuotaMap :: NamespacesGetBacklogQuotaMapParameters -> ClientM (Map.Map String BacklogQuotaImpl)
namespacesGetBacklogQuotaMap NamespacesGetBacklogQuotaMapParameters {..} = client (Proxy :: Proxy NamespacesGetBacklogQuotaMapAPI) (namespacesGetBacklogQuotaMapTenant) (namespacesGetBacklogQuotaMapNamespace)

-- ^ 
type NamespacesGetBookieAffinityGroupAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "property" Text :> Capture "namespace" Text :> "persistence" :> "bookieAffinity" :> Verb 'GET 200 '[JSON] BookieAffinityGroupDataImpl

data NamespacesGetBookieAffinityGroupParameters = NamespacesGetBookieAffinityGroupParameters
  { namespacesGetBookieAffinityGroupProperty :: Text -- ^ 
  , namespacesGetBookieAffinityGroupNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetBookieAffinityGroup :: NamespacesGetBookieAffinityGroupParameters -> ClientM BookieAffinityGroupDataImpl
namespacesGetBookieAffinityGroup NamespacesGetBookieAffinityGroupParameters {..} = client (Proxy :: Proxy NamespacesGetBookieAffinityGroupAPI) (namespacesGetBookieAffinityGroupProperty) (namespacesGetBookieAffinityGroupNamespace)

-- ^ 
type NamespacesGetBundlesDataAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "bundles" :> Verb 'GET 200 '[JSON] BundlesDataImpl

data NamespacesGetBundlesDataParameters = NamespacesGetBundlesDataParameters
  { namespacesGetBundlesDataTenant :: Text -- ^ 
  , namespacesGetBundlesDataNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetBundlesData :: NamespacesGetBundlesDataParameters -> ClientM BundlesDataImpl
namespacesGetBundlesData NamespacesGetBundlesDataParameters {..} = client (Proxy :: Proxy NamespacesGetBundlesDataAPI) (namespacesGetBundlesDataTenant) (namespacesGetBundlesDataNamespace)

-- ^ The backlog size is compared to the threshold periodically. A threshold of 0 disabled automatic compaction
type NamespacesGetCompactionThresholdAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "compactionThreshold" :> Verb 'GET 200 '[JSON] Integer

data NamespacesGetCompactionThresholdParameters = NamespacesGetCompactionThresholdParameters
  { namespacesGetCompactionThresholdTenant :: Text -- ^ 
  , namespacesGetCompactionThresholdNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetCompactionThreshold :: NamespacesGetCompactionThresholdParameters -> ClientM Integer
namespacesGetCompactionThreshold NamespacesGetCompactionThresholdParameters {..} = client (Proxy :: Proxy NamespacesGetCompactionThresholdAPI) (namespacesGetCompactionThresholdTenant) (namespacesGetCompactionThresholdNamespace)

-- ^ 
type NamespacesGetDeduplicationAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "deduplication" :> Verb 'GET 200 '[JSON] Bool

data NamespacesGetDeduplicationParameters = NamespacesGetDeduplicationParameters
  { namespacesGetDeduplicationTenant :: Text -- ^ 
  , namespacesGetDeduplicationNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetDeduplication :: NamespacesGetDeduplicationParameters -> ClientM Bool
namespacesGetDeduplication NamespacesGetDeduplicationParameters {..} = client (Proxy :: Proxy NamespacesGetDeduplicationAPI) (namespacesGetDeduplicationTenant) (namespacesGetDeduplicationNamespace)

-- ^ 
type NamespacesGetDeduplicationSnapshotIntervalAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "deduplicationSnapshotInterval" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetDeduplicationSnapshotIntervalParameters = NamespacesGetDeduplicationSnapshotIntervalParameters
  { namespacesGetDeduplicationSnapshotIntervalTenant :: Text -- ^ 
  , namespacesGetDeduplicationSnapshotIntervalNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetDeduplicationSnapshotInterval :: NamespacesGetDeduplicationSnapshotIntervalParameters -> ClientM Int
namespacesGetDeduplicationSnapshotInterval NamespacesGetDeduplicationSnapshotIntervalParameters {..} = client (Proxy :: Proxy NamespacesGetDeduplicationSnapshotIntervalAPI) (namespacesGetDeduplicationSnapshotIntervalTenant) (namespacesGetDeduplicationSnapshotIntervalNamespace)

-- ^ 
type NamespacesGetDelayedDeliveryPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "delayedDelivery" :> Verb 'GET 200 '[JSON] DelayedDeliveryPolicies

data NamespacesGetDelayedDeliveryPoliciesParameters = NamespacesGetDelayedDeliveryPoliciesParameters
  { namespacesGetDelayedDeliveryPoliciesTenant :: Text -- ^ 
  , namespacesGetDelayedDeliveryPoliciesNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetDelayedDeliveryPolicies :: NamespacesGetDelayedDeliveryPoliciesParameters -> ClientM DelayedDeliveryPolicies
namespacesGetDelayedDeliveryPolicies NamespacesGetDelayedDeliveryPoliciesParameters {..} = client (Proxy :: Proxy NamespacesGetDelayedDeliveryPoliciesAPI) (namespacesGetDelayedDeliveryPoliciesTenant) (namespacesGetDelayedDeliveryPoliciesNamespace)

-- ^ 
type NamespacesGetDispatchRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "dispatchRate" :> Verb 'GET 200 '[JSON] DispatchRate

data NamespacesGetDispatchRateParameters = NamespacesGetDispatchRateParameters
  { namespacesGetDispatchRateTenant :: Text -- ^ 
  , namespacesGetDispatchRateNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetDispatchRate :: NamespacesGetDispatchRateParameters -> ClientM DispatchRate
namespacesGetDispatchRate NamespacesGetDispatchRateParameters {..} = client (Proxy :: Proxy NamespacesGetDispatchRateAPI) (namespacesGetDispatchRateTenant) (namespacesGetDispatchRateNamespace)

-- ^ 
type NamespacesGetDispatcherPauseOnAckStatePersistentAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "dispatcherPauseOnAckStatePersistent" :> Verb 'GET 200 '[JSON] Bool

data NamespacesGetDispatcherPauseOnAckStatePersistentParameters = NamespacesGetDispatcherPauseOnAckStatePersistentParameters
  { namespacesGetDispatcherPauseOnAckStatePersistentTenant :: Text -- ^ 
  , namespacesGetDispatcherPauseOnAckStatePersistentNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetDispatcherPauseOnAckStatePersistent :: NamespacesGetDispatcherPauseOnAckStatePersistentParameters -> ClientM Bool
namespacesGetDispatcherPauseOnAckStatePersistent NamespacesGetDispatcherPauseOnAckStatePersistentParameters {..} = client (Proxy :: Proxy NamespacesGetDispatcherPauseOnAckStatePersistentAPI) (namespacesGetDispatcherPauseOnAckStatePersistentTenant) (namespacesGetDispatcherPauseOnAckStatePersistentNamespace)

-- ^ 
type NamespacesGetEncryptionRequiredAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "encryptionRequired" :> Verb 'GET 200 '[JSON] Bool

data NamespacesGetEncryptionRequiredParameters = NamespacesGetEncryptionRequiredParameters
  { namespacesGetEncryptionRequiredTenant :: Text -- ^ 
  , namespacesGetEncryptionRequiredNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetEncryptionRequired :: NamespacesGetEncryptionRequiredParameters -> ClientM Bool
namespacesGetEncryptionRequired NamespacesGetEncryptionRequiredParameters {..} = client (Proxy :: Proxy NamespacesGetEncryptionRequiredAPI) (namespacesGetEncryptionRequiredTenant) (namespacesGetEncryptionRequiredNamespace)

-- ^ 
type NamespacesGetEntryFiltersPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "entryFilters" :> Verb 'GET 200 '[JSON] EntryFilters

data NamespacesGetEntryFiltersPerTopicParameters = NamespacesGetEntryFiltersPerTopicParameters
  { namespacesGetEntryFiltersPerTopicTenant :: Text -- ^ 
  , namespacesGetEntryFiltersPerTopicNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetEntryFiltersPerTopic :: NamespacesGetEntryFiltersPerTopicParameters -> ClientM EntryFilters
namespacesGetEntryFiltersPerTopic NamespacesGetEntryFiltersPerTopicParameters {..} = client (Proxy :: Proxy NamespacesGetEntryFiltersPerTopicAPI) (namespacesGetEntryFiltersPerTopicTenant) (namespacesGetEntryFiltersPerTopicNamespace)

-- ^ 
type NamespacesGetInactiveTopicPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "inactiveTopicPolicies" :> Verb 'GET 200 '[JSON] InactiveTopicPolicies

data NamespacesGetInactiveTopicPoliciesParameters = NamespacesGetInactiveTopicPoliciesParameters
  { namespacesGetInactiveTopicPoliciesTenant :: Text -- ^ 
  , namespacesGetInactiveTopicPoliciesNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetInactiveTopicPolicies :: NamespacesGetInactiveTopicPoliciesParameters -> ClientM InactiveTopicPolicies
namespacesGetInactiveTopicPolicies NamespacesGetInactiveTopicPoliciesParameters {..} = client (Proxy :: Proxy NamespacesGetInactiveTopicPoliciesAPI) (namespacesGetInactiveTopicPoliciesTenant) (namespacesGetInactiveTopicPoliciesNamespace)

-- ^ 
type NamespacesGetIsAllowAutoUpdateSchemaAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "isAllowAutoUpdateSchema" :> Verb 'GET 200 '[JSON] Bool

data NamespacesGetIsAllowAutoUpdateSchemaParameters = NamespacesGetIsAllowAutoUpdateSchemaParameters
  { namespacesGetIsAllowAutoUpdateSchemaTenant :: Text -- ^ 
  , namespacesGetIsAllowAutoUpdateSchemaNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetIsAllowAutoUpdateSchema :: NamespacesGetIsAllowAutoUpdateSchemaParameters -> ClientM Bool
namespacesGetIsAllowAutoUpdateSchema NamespacesGetIsAllowAutoUpdateSchemaParameters {..} = client (Proxy :: Proxy NamespacesGetIsAllowAutoUpdateSchemaAPI) (namespacesGetIsAllowAutoUpdateSchemaTenant) (namespacesGetIsAllowAutoUpdateSchemaNamespace)

-- ^ 
type NamespacesGetMaxConsumersPerSubscriptionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxConsumersPerSubscription" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetMaxConsumersPerSubscriptionParameters = NamespacesGetMaxConsumersPerSubscriptionParameters
  { namespacesGetMaxConsumersPerSubscriptionTenant :: Text -- ^ 
  , namespacesGetMaxConsumersPerSubscriptionNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetMaxConsumersPerSubscription :: NamespacesGetMaxConsumersPerSubscriptionParameters -> ClientM Int
namespacesGetMaxConsumersPerSubscription NamespacesGetMaxConsumersPerSubscriptionParameters {..} = client (Proxy :: Proxy NamespacesGetMaxConsumersPerSubscriptionAPI) (namespacesGetMaxConsumersPerSubscriptionTenant) (namespacesGetMaxConsumersPerSubscriptionNamespace)

-- ^ 
type NamespacesGetMaxConsumersPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxConsumersPerTopic" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetMaxConsumersPerTopicParameters = NamespacesGetMaxConsumersPerTopicParameters
  { namespacesGetMaxConsumersPerTopicTenant :: Text -- ^ 
  , namespacesGetMaxConsumersPerTopicNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetMaxConsumersPerTopic :: NamespacesGetMaxConsumersPerTopicParameters -> ClientM Int
namespacesGetMaxConsumersPerTopic NamespacesGetMaxConsumersPerTopicParameters {..} = client (Proxy :: Proxy NamespacesGetMaxConsumersPerTopicAPI) (namespacesGetMaxConsumersPerTopicTenant) (namespacesGetMaxConsumersPerTopicNamespace)

-- ^ 
type NamespacesGetMaxProducersPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxProducersPerTopic" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetMaxProducersPerTopicParameters = NamespacesGetMaxProducersPerTopicParameters
  { namespacesGetMaxProducersPerTopicTenant :: Text -- ^ 
  , namespacesGetMaxProducersPerTopicNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetMaxProducersPerTopic :: NamespacesGetMaxProducersPerTopicParameters -> ClientM Int
namespacesGetMaxProducersPerTopic NamespacesGetMaxProducersPerTopicParameters {..} = client (Proxy :: Proxy NamespacesGetMaxProducersPerTopicAPI) (namespacesGetMaxProducersPerTopicTenant) (namespacesGetMaxProducersPerTopicNamespace)

-- ^ 
type NamespacesGetMaxSubscriptionsPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxSubscriptionsPerTopic" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetMaxSubscriptionsPerTopicParameters = NamespacesGetMaxSubscriptionsPerTopicParameters
  { namespacesGetMaxSubscriptionsPerTopicTenant :: Text -- ^ 
  , namespacesGetMaxSubscriptionsPerTopicNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetMaxSubscriptionsPerTopic :: NamespacesGetMaxSubscriptionsPerTopicParameters -> ClientM Int
namespacesGetMaxSubscriptionsPerTopic NamespacesGetMaxSubscriptionsPerTopicParameters {..} = client (Proxy :: Proxy NamespacesGetMaxSubscriptionsPerTopicAPI) (namespacesGetMaxSubscriptionsPerTopicTenant) (namespacesGetMaxSubscriptionsPerTopicNamespace)

-- ^ 
type NamespacesGetMaxTopicsPerNamespaceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxTopicsPerNamespace" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetMaxTopicsPerNamespaceParameters = NamespacesGetMaxTopicsPerNamespaceParameters
  { namespacesGetMaxTopicsPerNamespaceTenant :: Text -- ^ 
  , namespacesGetMaxTopicsPerNamespaceNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetMaxTopicsPerNamespace :: NamespacesGetMaxTopicsPerNamespaceParameters -> ClientM Int
namespacesGetMaxTopicsPerNamespace NamespacesGetMaxTopicsPerNamespaceParameters {..} = client (Proxy :: Proxy NamespacesGetMaxTopicsPerNamespaceAPI) (namespacesGetMaxTopicsPerNamespaceTenant) (namespacesGetMaxTopicsPerNamespaceNamespace)

-- ^ 
type NamespacesGetMaxUnackedMessagesPerConsumerAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxUnackedMessagesPerConsumer" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetMaxUnackedMessagesPerConsumerParameters = NamespacesGetMaxUnackedMessagesPerConsumerParameters
  { namespacesGetMaxUnackedMessagesPerConsumerTenant :: Text -- ^ 
  , namespacesGetMaxUnackedMessagesPerConsumerNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetMaxUnackedMessagesPerConsumer :: NamespacesGetMaxUnackedMessagesPerConsumerParameters -> ClientM Int
namespacesGetMaxUnackedMessagesPerConsumer NamespacesGetMaxUnackedMessagesPerConsumerParameters {..} = client (Proxy :: Proxy NamespacesGetMaxUnackedMessagesPerConsumerAPI) (namespacesGetMaxUnackedMessagesPerConsumerTenant) (namespacesGetMaxUnackedMessagesPerConsumerNamespace)

-- ^ 
type NamespacesGetMaxUnackedmessagesPerSubscriptionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxUnackedMessagesPerSubscription" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetMaxUnackedmessagesPerSubscriptionParameters = NamespacesGetMaxUnackedmessagesPerSubscriptionParameters
  { namespacesGetMaxUnackedmessagesPerSubscriptionTenant :: Text -- ^ 
  , namespacesGetMaxUnackedmessagesPerSubscriptionNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetMaxUnackedmessagesPerSubscription :: NamespacesGetMaxUnackedmessagesPerSubscriptionParameters -> ClientM Int
namespacesGetMaxUnackedmessagesPerSubscription NamespacesGetMaxUnackedmessagesPerSubscriptionParameters {..} = client (Proxy :: Proxy NamespacesGetMaxUnackedmessagesPerSubscriptionAPI) (namespacesGetMaxUnackedmessagesPerSubscriptionTenant) (namespacesGetMaxUnackedmessagesPerSubscriptionNamespace)

-- ^ 
type NamespacesGetNamespaceAllowedClustersAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "allowedClusters" :> Verb 'GET 200 '[JSON] [Text]

data NamespacesGetNamespaceAllowedClustersParameters = NamespacesGetNamespaceAllowedClustersParameters
  { namespacesGetNamespaceAllowedClustersTenant :: Text -- ^ 
  , namespacesGetNamespaceAllowedClustersNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetNamespaceAllowedClusters :: NamespacesGetNamespaceAllowedClustersParameters -> ClientM [Text]
namespacesGetNamespaceAllowedClusters NamespacesGetNamespaceAllowedClustersParameters {..} = client (Proxy :: Proxy NamespacesGetNamespaceAllowedClustersAPI) (namespacesGetNamespaceAllowedClustersTenant) (namespacesGetNamespaceAllowedClustersNamespace)

-- ^ 
type NamespacesGetNamespaceAntiAffinityGroupAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "antiAffinity" :> Verb 'GET 200 '[JSON] Text

data NamespacesGetNamespaceAntiAffinityGroupParameters = NamespacesGetNamespaceAntiAffinityGroupParameters
  { namespacesGetNamespaceAntiAffinityGroupTenant :: Text -- ^ 
  , namespacesGetNamespaceAntiAffinityGroupNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetNamespaceAntiAffinityGroup :: NamespacesGetNamespaceAntiAffinityGroupParameters -> ClientM Text
namespacesGetNamespaceAntiAffinityGroup NamespacesGetNamespaceAntiAffinityGroupParameters {..} = client (Proxy :: Proxy NamespacesGetNamespaceAntiAffinityGroupAPI) (namespacesGetNamespaceAntiAffinityGroupTenant) (namespacesGetNamespaceAntiAffinityGroupNamespace)

-- ^ 
type NamespacesGetNamespaceMessageTTLAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "messageTTL" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetNamespaceMessageTTLParameters = NamespacesGetNamespaceMessageTTLParameters
  { namespacesGetNamespaceMessageTTLTenant :: Text -- ^ 
  , namespacesGetNamespaceMessageTTLNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetNamespaceMessageTTL :: NamespacesGetNamespaceMessageTTLParameters -> ClientM Int
namespacesGetNamespaceMessageTTL NamespacesGetNamespaceMessageTTLParameters {..} = client (Proxy :: Proxy NamespacesGetNamespaceMessageTTLAPI) (namespacesGetNamespaceMessageTTLTenant) (namespacesGetNamespaceMessageTTLNamespace)

-- ^ 
type NamespacesGetNamespaceReplicationClustersAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "replication" :> Verb 'GET 200 '[JSON] [Text]

data NamespacesGetNamespaceReplicationClustersParameters = NamespacesGetNamespaceReplicationClustersParameters
  { namespacesGetNamespaceReplicationClustersTenant :: Text -- ^ 
  , namespacesGetNamespaceReplicationClustersNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetNamespaceReplicationClusters :: NamespacesGetNamespaceReplicationClustersParameters -> ClientM [Text]
namespacesGetNamespaceReplicationClusters NamespacesGetNamespaceReplicationClustersParameters {..} = client (Proxy :: Proxy NamespacesGetNamespaceReplicationClustersAPI) (namespacesGetNamespaceReplicationClustersTenant) (namespacesGetNamespaceReplicationClustersNamespace)

-- ^ 
type NamespacesGetNamespaceResourceGroupAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "resourcegroup" :> Verb 'GET 200 '[JSON] Text

data NamespacesGetNamespaceResourceGroupParameters = NamespacesGetNamespaceResourceGroupParameters
  { namespacesGetNamespaceResourceGroupTenant :: Text -- ^ 
  , namespacesGetNamespaceResourceGroupNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetNamespaceResourceGroup :: NamespacesGetNamespaceResourceGroupParameters -> ClientM Text
namespacesGetNamespaceResourceGroup NamespacesGetNamespaceResourceGroupParameters {..} = client (Proxy :: Proxy NamespacesGetNamespaceResourceGroupAPI) (namespacesGetNamespaceResourceGroupTenant) (namespacesGetNamespaceResourceGroupNamespace)

-- ^ A negative value denotes that deletion has been completely disabled. 'null' denotes that the topics in the namespace will fall back to the broker default for deletion lag.
type NamespacesGetOffloadDeletionLagAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "offloadDeletionLagMs" :> Verb 'GET 200 '[JSON] Integer

data NamespacesGetOffloadDeletionLagParameters = NamespacesGetOffloadDeletionLagParameters
  { namespacesGetOffloadDeletionLagTenant :: Text -- ^ 
  , namespacesGetOffloadDeletionLagNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetOffloadDeletionLag :: NamespacesGetOffloadDeletionLagParameters -> ClientM Integer
namespacesGetOffloadDeletionLag NamespacesGetOffloadDeletionLagParameters {..} = client (Proxy :: Proxy NamespacesGetOffloadDeletionLagAPI) (namespacesGetOffloadDeletionLagTenant) (namespacesGetOffloadDeletionLagNamespace)

-- ^ 
type NamespacesGetOffloadPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "offloadPolicies" :> Verb 'GET 200 '[JSON] OffloadPolicies

data NamespacesGetOffloadPoliciesParameters = NamespacesGetOffloadPoliciesParameters
  { namespacesGetOffloadPoliciesTenant :: Text -- ^ 
  , namespacesGetOffloadPoliciesNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetOffloadPolicies :: NamespacesGetOffloadPoliciesParameters -> ClientM OffloadPolicies
namespacesGetOffloadPolicies NamespacesGetOffloadPoliciesParameters {..} = client (Proxy :: Proxy NamespacesGetOffloadPoliciesAPI) (namespacesGetOffloadPoliciesTenant) (namespacesGetOffloadPoliciesNamespace)

-- ^ A negative value disables automatic offloading
type NamespacesGetOffloadThresholdAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "offloadThreshold" :> Verb 'GET 200 '[JSON] Integer

data NamespacesGetOffloadThresholdParameters = NamespacesGetOffloadThresholdParameters
  { namespacesGetOffloadThresholdTenant :: Text -- ^ 
  , namespacesGetOffloadThresholdNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetOffloadThreshold :: NamespacesGetOffloadThresholdParameters -> ClientM Integer
namespacesGetOffloadThreshold NamespacesGetOffloadThresholdParameters {..} = client (Proxy :: Proxy NamespacesGetOffloadThresholdAPI) (namespacesGetOffloadThresholdTenant) (namespacesGetOffloadThresholdNamespace)

-- ^ A negative value disables automatic offloading
type NamespacesGetOffloadThresholdInSecondsAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "offloadThresholdInSeconds" :> Verb 'GET 200 '[JSON] Integer

data NamespacesGetOffloadThresholdInSecondsParameters = NamespacesGetOffloadThresholdInSecondsParameters
  { namespacesGetOffloadThresholdInSecondsTenant :: Text -- ^ 
  , namespacesGetOffloadThresholdInSecondsNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetOffloadThresholdInSeconds :: NamespacesGetOffloadThresholdInSecondsParameters -> ClientM Integer
namespacesGetOffloadThresholdInSeconds NamespacesGetOffloadThresholdInSecondsParameters {..} = client (Proxy :: Proxy NamespacesGetOffloadThresholdInSecondsAPI) (namespacesGetOffloadThresholdInSecondsTenant) (namespacesGetOffloadThresholdInSecondsNamespace)

-- ^ Returns a nested map structure which Swagger does not fully support for display. Structure: Map<String, Set<String>>. Please refer to this structure for details.
type NamespacesGetPermissionOnSubscriptionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "permissions" :> "subscription" :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

data NamespacesGetPermissionOnSubscriptionParameters = NamespacesGetPermissionOnSubscriptionParameters
  { namespacesGetPermissionOnSubscriptionTenant :: Text -- ^ 
  , namespacesGetPermissionOnSubscriptionNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetPermissionOnSubscription :: NamespacesGetPermissionOnSubscriptionParameters -> ClientM (Map.Map String Text)
namespacesGetPermissionOnSubscription NamespacesGetPermissionOnSubscriptionParameters {..} = client (Proxy :: Proxy NamespacesGetPermissionOnSubscriptionAPI) (namespacesGetPermissionOnSubscriptionTenant) (namespacesGetPermissionOnSubscriptionNamespace)

-- ^ Returns a nested map structure which Swagger does not fully support for display. Structure: Map<String, Set<AuthAction>>. Please refer to this structure for details.
type NamespacesGetPermissionsAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "permissions" :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

data NamespacesGetPermissionsParameters = NamespacesGetPermissionsParameters
  { namespacesGetPermissionsTenant :: Text -- ^ 
  , namespacesGetPermissionsNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetPermissions :: NamespacesGetPermissionsParameters -> ClientM (Map.Map String Text)
namespacesGetPermissions NamespacesGetPermissionsParameters {..} = client (Proxy :: Proxy NamespacesGetPermissionsAPI) (namespacesGetPermissionsTenant) (namespacesGetPermissionsNamespace)

-- ^ 
type NamespacesGetPersistenceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "persistence" :> Verb 'GET 200 '[JSON] PersistencePolicies

data NamespacesGetPersistenceParameters = NamespacesGetPersistenceParameters
  { namespacesGetPersistenceTenant :: Text -- ^ 
  , namespacesGetPersistenceNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetPersistence :: NamespacesGetPersistenceParameters -> ClientM PersistencePolicies
namespacesGetPersistence NamespacesGetPersistenceParameters {..} = client (Proxy :: Proxy NamespacesGetPersistenceAPI) (namespacesGetPersistenceTenant) (namespacesGetPersistenceNamespace)

-- ^ 
type NamespacesGetPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> Verb 'GET 200 '[JSON] Policies

data NamespacesGetPoliciesParameters = NamespacesGetPoliciesParameters
  { namespacesGetPoliciesTenant :: Text -- ^ 
  , namespacesGetPoliciesNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetPolicies :: NamespacesGetPoliciesParameters -> ClientM Policies
namespacesGetPolicies NamespacesGetPoliciesParameters {..} = client (Proxy :: Proxy NamespacesGetPoliciesAPI) (namespacesGetPoliciesTenant) (namespacesGetPoliciesNamespace)

-- ^ 
type NamespacesGetPropertiesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "properties" :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

data NamespacesGetPropertiesParameters = NamespacesGetPropertiesParameters
  { namespacesGetPropertiesTenant :: Text -- ^ 
  , namespacesGetPropertiesNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetProperties :: NamespacesGetPropertiesParameters -> ClientM (Map.Map String Text)
namespacesGetProperties NamespacesGetPropertiesParameters {..} = client (Proxy :: Proxy NamespacesGetPropertiesAPI) (namespacesGetPropertiesTenant) (namespacesGetPropertiesNamespace)

-- ^ 
type NamespacesGetPropertyAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "property" :> Capture "key" Text :> Verb 'GET 200 '[JSON] Text

data NamespacesGetPropertyParameters = NamespacesGetPropertyParameters
  { namespacesGetPropertyTenant :: Text -- ^ 
  , namespacesGetPropertyNamespace :: Text -- ^ 
  , namespacesGetPropertyKey :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetProperty :: NamespacesGetPropertyParameters -> ClientM Text
namespacesGetProperty NamespacesGetPropertyParameters {..} = client (Proxy :: Proxy NamespacesGetPropertyAPI) (namespacesGetPropertyTenant) (namespacesGetPropertyNamespace) (namespacesGetPropertyKey)

-- ^ 
type NamespacesGetReplicatorDispatchRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "replicatorDispatchRate" :> Verb 'GET 200 '[JSON] DispatchRateImpl

data NamespacesGetReplicatorDispatchRateParameters = NamespacesGetReplicatorDispatchRateParameters
  { namespacesGetReplicatorDispatchRateTenant :: Text -- ^ 
  , namespacesGetReplicatorDispatchRateNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetReplicatorDispatchRate :: NamespacesGetReplicatorDispatchRateParameters -> ClientM DispatchRateImpl
namespacesGetReplicatorDispatchRate NamespacesGetReplicatorDispatchRateParameters {..} = client (Proxy :: Proxy NamespacesGetReplicatorDispatchRateAPI) (namespacesGetReplicatorDispatchRateTenant) (namespacesGetReplicatorDispatchRateNamespace)

-- ^ 
type NamespacesGetRetentionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "retention" :> Verb 'GET 200 '[JSON] RetentionPolicies

data NamespacesGetRetentionParameters = NamespacesGetRetentionParameters
  { namespacesGetRetentionTenant :: Text -- ^ 
  , namespacesGetRetentionNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetRetention :: NamespacesGetRetentionParameters -> ClientM RetentionPolicies
namespacesGetRetention NamespacesGetRetentionParameters {..} = client (Proxy :: Proxy NamespacesGetRetentionAPI) (namespacesGetRetentionTenant) (namespacesGetRetentionNamespace)

-- ^ The value AutoUpdateDisabled prevents producers from updating the schema.  If set to AutoUpdateDisabled, schemas must be updated through the REST api
type NamespacesGetSchemaAutoUpdateCompatibilityStrategyAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "schemaAutoUpdateCompatibilityStrategy" :> Verb 'GET 200 '[JSON] Text

data NamespacesGetSchemaAutoUpdateCompatibilityStrategyParameters = NamespacesGetSchemaAutoUpdateCompatibilityStrategyParameters
  { namespacesGetSchemaAutoUpdateCompatibilityStrategyTenant :: Text -- ^ 
  , namespacesGetSchemaAutoUpdateCompatibilityStrategyNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetSchemaAutoUpdateCompatibilityStrategy :: NamespacesGetSchemaAutoUpdateCompatibilityStrategyParameters -> ClientM Text
namespacesGetSchemaAutoUpdateCompatibilityStrategy NamespacesGetSchemaAutoUpdateCompatibilityStrategyParameters {..} = client (Proxy :: Proxy NamespacesGetSchemaAutoUpdateCompatibilityStrategyAPI) (namespacesGetSchemaAutoUpdateCompatibilityStrategyTenant) (namespacesGetSchemaAutoUpdateCompatibilityStrategyNamespace)

-- ^ 
type NamespacesGetSchemaCompatibilityStrategyAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "schemaCompatibilityStrategy" :> Verb 'GET 200 '[JSON] Text

data NamespacesGetSchemaCompatibilityStrategyParameters = NamespacesGetSchemaCompatibilityStrategyParameters
  { namespacesGetSchemaCompatibilityStrategyTenant :: Text -- ^ 
  , namespacesGetSchemaCompatibilityStrategyNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetSchemaCompatibilityStrategy :: NamespacesGetSchemaCompatibilityStrategyParameters -> ClientM Text
namespacesGetSchemaCompatibilityStrategy NamespacesGetSchemaCompatibilityStrategyParameters {..} = client (Proxy :: Proxy NamespacesGetSchemaCompatibilityStrategyAPI) (namespacesGetSchemaCompatibilityStrategyTenant) (namespacesGetSchemaCompatibilityStrategyNamespace)

-- ^ If the flag is set to true, when a producer without a schema attempts to produce to a topic with schema in this namespace, the producer will be failed to connect. PLEASE be carefully on using this, since non-java clients don't support schema.if you enable this setting, it will cause non-java clients failed to produce.
type NamespacesGetSchemaValidtionEnforcedAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "schemaValidationEnforced" :> QueryParam "applied" Bool :> Verb 'GET 200 '[JSON] Bool

data NamespacesGetSchemaValidtionEnforcedParameters = NamespacesGetSchemaValidtionEnforcedParameters
  { namespacesGetSchemaValidtionEnforcedTenant :: Text -- ^ 
  , namespacesGetSchemaValidtionEnforcedNamespace :: Text -- ^ 
  , namespacesGetSchemaValidtionEnforcedApplied :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetSchemaValidtionEnforced :: NamespacesGetSchemaValidtionEnforcedParameters -> ClientM Bool
namespacesGetSchemaValidtionEnforced NamespacesGetSchemaValidtionEnforcedParameters {..} = client (Proxy :: Proxy NamespacesGetSchemaValidtionEnforcedAPI) (namespacesGetSchemaValidtionEnforcedTenant) (namespacesGetSchemaValidtionEnforcedNamespace) (namespacesGetSchemaValidtionEnforcedApplied)

-- ^ 
type NamespacesGetSubscribeRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscribeRate" :> Verb 'GET 200 '[JSON] SubscribeRate

data NamespacesGetSubscribeRateParameters = NamespacesGetSubscribeRateParameters
  { namespacesGetSubscribeRateTenant :: Text -- ^ 
  , namespacesGetSubscribeRateNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetSubscribeRate :: NamespacesGetSubscribeRateParameters -> ClientM SubscribeRate
namespacesGetSubscribeRate NamespacesGetSubscribeRateParameters {..} = client (Proxy :: Proxy NamespacesGetSubscribeRateAPI) (namespacesGetSubscribeRateTenant) (namespacesGetSubscribeRateNamespace)

-- ^ 
type NamespacesGetSubscriptionAuthModeAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionAuthMode" :> Verb 'GET 200 '[JSON] Text

data NamespacesGetSubscriptionAuthModeParameters = NamespacesGetSubscriptionAuthModeParameters
  { namespacesGetSubscriptionAuthModeTenant :: Text -- ^ 
  , namespacesGetSubscriptionAuthModeNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetSubscriptionAuthMode :: NamespacesGetSubscriptionAuthModeParameters -> ClientM Text
namespacesGetSubscriptionAuthMode NamespacesGetSubscriptionAuthModeParameters {..} = client (Proxy :: Proxy NamespacesGetSubscriptionAuthModeAPI) (namespacesGetSubscriptionAuthModeTenant) (namespacesGetSubscriptionAuthModeNamespace)

-- ^ 
type NamespacesGetSubscriptionDispatchRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionDispatchRate" :> Verb 'GET 200 '[JSON] DispatchRate

data NamespacesGetSubscriptionDispatchRateParameters = NamespacesGetSubscriptionDispatchRateParameters
  { namespacesGetSubscriptionDispatchRateTenant :: Text -- ^ 
  , namespacesGetSubscriptionDispatchRateNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetSubscriptionDispatchRate :: NamespacesGetSubscriptionDispatchRateParameters -> ClientM DispatchRate
namespacesGetSubscriptionDispatchRate NamespacesGetSubscriptionDispatchRateParameters {..} = client (Proxy :: Proxy NamespacesGetSubscriptionDispatchRateAPI) (namespacesGetSubscriptionDispatchRateTenant) (namespacesGetSubscriptionDispatchRateNamespace)

-- ^ 
type NamespacesGetSubscriptionExpirationTimeAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionExpirationTime" :> Verb 'GET 200 '[JSON] Int

data NamespacesGetSubscriptionExpirationTimeParameters = NamespacesGetSubscriptionExpirationTimeParameters
  { namespacesGetSubscriptionExpirationTimeTenant :: Text -- ^ 
  , namespacesGetSubscriptionExpirationTimeNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetSubscriptionExpirationTime :: NamespacesGetSubscriptionExpirationTimeParameters -> ClientM Int
namespacesGetSubscriptionExpirationTime NamespacesGetSubscriptionExpirationTimeParameters {..} = client (Proxy :: Proxy NamespacesGetSubscriptionExpirationTimeAPI) (namespacesGetSubscriptionExpirationTimeTenant) (namespacesGetSubscriptionExpirationTimeNamespace)

-- ^ 
type NamespacesGetSubscriptionTypesEnabledAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionTypesEnabled" :> Verb 'GET 200 '[JSON] [Text]

data NamespacesGetSubscriptionTypesEnabledParameters = NamespacesGetSubscriptionTypesEnabledParameters
  { namespacesGetSubscriptionTypesEnabledTenant :: Text -- ^ 
  , namespacesGetSubscriptionTypesEnabledNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetSubscriptionTypesEnabled :: NamespacesGetSubscriptionTypesEnabledParameters -> ClientM [Text]
namespacesGetSubscriptionTypesEnabled NamespacesGetSubscriptionTypesEnabledParameters {..} = client (Proxy :: Proxy NamespacesGetSubscriptionTypesEnabledAPI) (namespacesGetSubscriptionTypesEnabledTenant) (namespacesGetSubscriptionTypesEnabledNamespace)

-- ^ 
type NamespacesGetTenantNamespacesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Verb 'GET 200 '[JSON] [Text]

data NamespacesGetTenantNamespacesParameters = NamespacesGetTenantNamespacesParameters
  { namespacesGetTenantNamespacesTenant :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetTenantNamespaces :: NamespacesGetTenantNamespacesParameters -> ClientM [Text]
namespacesGetTenantNamespaces NamespacesGetTenantNamespacesParameters {..} = client (Proxy :: Proxy NamespacesGetTenantNamespacesAPI) (namespacesGetTenantNamespacesTenant)

-- ^ 
type NamespacesGetTopicHashPositionsAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> "topicHashPositions" :> QueryParam "topics" (QueryList 'MultiParamArray (Text)) :> Verb 'GET 200 '[JSON] TopicHashPositions

data NamespacesGetTopicHashPositionsParameters = NamespacesGetTopicHashPositionsParameters
  { namespacesGetTopicHashPositionsTenant :: Text -- ^ 
  , namespacesGetTopicHashPositionsNamespace :: Text -- ^ 
  , namespacesGetTopicHashPositionsBundle :: Text -- ^ 
  , namespacesGetTopicHashPositionsTopics :: Maybe [Text] -- ^ 
  } deriving (Show, Eq, Generic)

namespacesGetTopicHashPositions :: NamespacesGetTopicHashPositionsParameters -> ClientM TopicHashPositions
namespacesGetTopicHashPositions NamespacesGetTopicHashPositionsParameters {..} = client (Proxy :: Proxy NamespacesGetTopicHashPositionsAPI) (namespacesGetTopicHashPositionsTenant) (namespacesGetTopicHashPositionsNamespace) (namespacesGetTopicHashPositionsBundle) (QueryList <$> namespacesGetTopicHashPositionsTopics)

-- ^ 
type NamespacesGetTopicsAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "topics" :> QueryParam "mode" Text :> QueryParam "includeSystemTopic" Bool :> Verb 'GET 200 '[JSON] [Text]

data NamespacesGetTopicsParameters = NamespacesGetTopicsParameters
  { namespacesGetTopicsTenant :: Text -- ^ 
  , namespacesGetTopicsNamespace :: Text -- ^ 
  , namespacesGetTopicsMode :: Maybe Text -- ^ 
  , namespacesGetTopicsIncludeSystemTopic :: Maybe Bool -- ^ Include system topic
  } deriving (Show, Eq, Generic)

namespacesGetTopics :: NamespacesGetTopicsParameters -> ClientM [Text]
namespacesGetTopics NamespacesGetTopicsParameters {..} = client (Proxy :: Proxy NamespacesGetTopicsAPI) (namespacesGetTopicsTenant) (namespacesGetTopicsNamespace) (namespacesGetTopicsMode) (namespacesGetTopicsIncludeSystemTopic)

-- ^ 
type NamespacesGrantPermissionOnNamespaceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "permissions" :> Capture "role" Text :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data NamespacesGrantPermissionOnNamespaceParameters = NamespacesGrantPermissionOnNamespaceParameters
  { namespacesGrantPermissionOnNamespaceTenant :: Text -- ^ 
  , namespacesGrantPermissionOnNamespaceNamespace :: Text -- ^ 
  , namespacesGrantPermissionOnNamespaceRole :: Text -- ^ 
  , namespacesGrantPermissionOnNamespaceBody :: [Text] -- ^ List of permissions for the specified role
  } deriving (Show, Eq, Generic)

namespacesGrantPermissionOnNamespace :: NamespacesGrantPermissionOnNamespaceParameters -> ClientM NoContent
namespacesGrantPermissionOnNamespace NamespacesGrantPermissionOnNamespaceParameters {..} = client (Proxy :: Proxy NamespacesGrantPermissionOnNamespaceAPI) (namespacesGrantPermissionOnNamespaceTenant) (namespacesGrantPermissionOnNamespaceNamespace) (namespacesGrantPermissionOnNamespaceRole) namespacesGrantPermissionOnNamespaceBody

-- ^ 
type NamespacesGrantPermissionsOnTopicsAPI =
      "admin" :> "v2" :> "namespaces" :> "grantPermissionsOnTopics" :> Verb 'POST 200 '[JSON] NoContent

namespacesGrantPermissionsOnTopics :: ClientM NoContent
namespacesGrantPermissionsOnTopics = client (Proxy :: Proxy NamespacesGrantPermissionsOnTopicsAPI)

-- ^ 
type NamespacesModifyDeduplicationAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "deduplication" :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesModifyDeduplicationParameters = NamespacesModifyDeduplicationParameters
  { namespacesModifyDeduplicationTenant :: Text -- ^ 
  , namespacesModifyDeduplicationNamespace :: Text -- ^ 
  , namespacesModifyDeduplicationBody :: Bool -- ^ Flag for disabling or enabling broker side deduplication for all topics in the specified namespace
  } deriving (Show, Eq, Generic)

namespacesModifyDeduplication :: NamespacesModifyDeduplicationParameters -> ClientM NoContent
namespacesModifyDeduplication NamespacesModifyDeduplicationParameters {..} = client (Proxy :: Proxy NamespacesModifyDeduplicationAPI) (namespacesModifyDeduplicationTenant) (namespacesModifyDeduplicationNamespace) namespacesModifyDeduplicationBody

-- ^ 
type NamespacesModifyEncryptionRequiredAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "encryptionRequired" :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesModifyEncryptionRequiredParameters = NamespacesModifyEncryptionRequiredParameters
  { namespacesModifyEncryptionRequiredTenant :: Text -- ^ 
  , namespacesModifyEncryptionRequiredNamespace :: Text -- ^ 
  , namespacesModifyEncryptionRequiredBody :: Bool -- ^ Flag defining if message encryption is required
  } deriving (Show, Eq, Generic)

namespacesModifyEncryptionRequired :: NamespacesModifyEncryptionRequiredParameters -> ClientM NoContent
namespacesModifyEncryptionRequired NamespacesModifyEncryptionRequiredParameters {..} = client (Proxy :: Proxy NamespacesModifyEncryptionRequiredAPI) (namespacesModifyEncryptionRequiredTenant) (namespacesModifyEncryptionRequiredNamespace) namespacesModifyEncryptionRequiredBody

-- ^ 
type NamespacesRemoveAutoSubscriptionCreationAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "autoSubscriptionCreation" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveAutoSubscriptionCreationParameters = NamespacesRemoveAutoSubscriptionCreationParameters
  { namespacesRemoveAutoSubscriptionCreationTenant :: Text -- ^ 
  , namespacesRemoveAutoSubscriptionCreationNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveAutoSubscriptionCreation :: NamespacesRemoveAutoSubscriptionCreationParameters -> ClientM NoContent
namespacesRemoveAutoSubscriptionCreation NamespacesRemoveAutoSubscriptionCreationParameters {..} = client (Proxy :: Proxy NamespacesRemoveAutoSubscriptionCreationAPI) (namespacesRemoveAutoSubscriptionCreationTenant) (namespacesRemoveAutoSubscriptionCreationNamespace)

-- ^ 
type NamespacesRemoveAutoTopicCreationAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "autoTopicCreation" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveAutoTopicCreationParameters = NamespacesRemoveAutoTopicCreationParameters
  { namespacesRemoveAutoTopicCreationTenant :: Text -- ^ 
  , namespacesRemoveAutoTopicCreationNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveAutoTopicCreation :: NamespacesRemoveAutoTopicCreationParameters -> ClientM NoContent
namespacesRemoveAutoTopicCreation NamespacesRemoveAutoTopicCreationParameters {..} = client (Proxy :: Proxy NamespacesRemoveAutoTopicCreationAPI) (namespacesRemoveAutoTopicCreationTenant) (namespacesRemoveAutoTopicCreationNamespace)

-- ^ 
type NamespacesRemoveBacklogQuotaAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "backlogQuota" :> QueryParam "backlogQuotaType" Text :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveBacklogQuotaParameters = NamespacesRemoveBacklogQuotaParameters
  { namespacesRemoveBacklogQuotaTenant :: Text -- ^ 
  , namespacesRemoveBacklogQuotaNamespace :: Text -- ^ 
  , namespacesRemoveBacklogQuotaBacklogQuotaType :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveBacklogQuota :: NamespacesRemoveBacklogQuotaParameters -> ClientM NoContent
namespacesRemoveBacklogQuota NamespacesRemoveBacklogQuotaParameters {..} = client (Proxy :: Proxy NamespacesRemoveBacklogQuotaAPI) (namespacesRemoveBacklogQuotaTenant) (namespacesRemoveBacklogQuotaNamespace) (namespacesRemoveBacklogQuotaBacklogQuotaType)

-- ^ 
type NamespacesRemoveDeduplicationAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "deduplication" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveDeduplicationParameters = NamespacesRemoveDeduplicationParameters
  { namespacesRemoveDeduplicationTenant :: Text -- ^ 
  , namespacesRemoveDeduplicationNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveDeduplication :: NamespacesRemoveDeduplicationParameters -> ClientM NoContent
namespacesRemoveDeduplication NamespacesRemoveDeduplicationParameters {..} = client (Proxy :: Proxy NamespacesRemoveDeduplicationAPI) (namespacesRemoveDeduplicationTenant) (namespacesRemoveDeduplicationNamespace)

-- ^ 
type NamespacesRemoveDelayedDeliveryPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "delayedDelivery" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveDelayedDeliveryPoliciesParameters = NamespacesRemoveDelayedDeliveryPoliciesParameters
  { namespacesRemoveDelayedDeliveryPoliciesTenant :: Text -- ^ 
  , namespacesRemoveDelayedDeliveryPoliciesNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveDelayedDeliveryPolicies :: NamespacesRemoveDelayedDeliveryPoliciesParameters -> ClientM NoContent
namespacesRemoveDelayedDeliveryPolicies NamespacesRemoveDelayedDeliveryPoliciesParameters {..} = client (Proxy :: Proxy NamespacesRemoveDelayedDeliveryPoliciesAPI) (namespacesRemoveDelayedDeliveryPoliciesTenant) (namespacesRemoveDelayedDeliveryPoliciesNamespace)

-- ^ 
type NamespacesRemoveDispatcherPauseOnAckStatePersistentAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "dispatcherPauseOnAckStatePersistent" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveDispatcherPauseOnAckStatePersistentParameters = NamespacesRemoveDispatcherPauseOnAckStatePersistentParameters
  { namespacesRemoveDispatcherPauseOnAckStatePersistentTenant :: Text -- ^ 
  , namespacesRemoveDispatcherPauseOnAckStatePersistentNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveDispatcherPauseOnAckStatePersistent :: NamespacesRemoveDispatcherPauseOnAckStatePersistentParameters -> ClientM NoContent
namespacesRemoveDispatcherPauseOnAckStatePersistent NamespacesRemoveDispatcherPauseOnAckStatePersistentParameters {..} = client (Proxy :: Proxy NamespacesRemoveDispatcherPauseOnAckStatePersistentAPI) (namespacesRemoveDispatcherPauseOnAckStatePersistentTenant) (namespacesRemoveDispatcherPauseOnAckStatePersistentNamespace)

-- ^ 
type NamespacesRemoveInactiveTopicPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "inactiveTopicPolicies" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveInactiveTopicPoliciesParameters = NamespacesRemoveInactiveTopicPoliciesParameters
  { namespacesRemoveInactiveTopicPoliciesTenant :: Text -- ^ 
  , namespacesRemoveInactiveTopicPoliciesNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveInactiveTopicPolicies :: NamespacesRemoveInactiveTopicPoliciesParameters -> ClientM NoContent
namespacesRemoveInactiveTopicPolicies NamespacesRemoveInactiveTopicPoliciesParameters {..} = client (Proxy :: Proxy NamespacesRemoveInactiveTopicPoliciesAPI) (namespacesRemoveInactiveTopicPoliciesTenant) (namespacesRemoveInactiveTopicPoliciesNamespace)

-- ^ 
type NamespacesRemoveMaxConsumersPerSubscriptionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxConsumersPerSubscription" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveMaxConsumersPerSubscriptionParameters = NamespacesRemoveMaxConsumersPerSubscriptionParameters
  { namespacesRemoveMaxConsumersPerSubscriptionTenant :: Text -- ^ 
  , namespacesRemoveMaxConsumersPerSubscriptionNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveMaxConsumersPerSubscription :: NamespacesRemoveMaxConsumersPerSubscriptionParameters -> ClientM NoContent
namespacesRemoveMaxConsumersPerSubscription NamespacesRemoveMaxConsumersPerSubscriptionParameters {..} = client (Proxy :: Proxy NamespacesRemoveMaxConsumersPerSubscriptionAPI) (namespacesRemoveMaxConsumersPerSubscriptionTenant) (namespacesRemoveMaxConsumersPerSubscriptionNamespace)

-- ^ 
type NamespacesRemoveMaxConsumersPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxConsumersPerTopic" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveMaxConsumersPerTopicParameters = NamespacesRemoveMaxConsumersPerTopicParameters
  { namespacesRemoveMaxConsumersPerTopicTenant :: Text -- ^ 
  , namespacesRemoveMaxConsumersPerTopicNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveMaxConsumersPerTopic :: NamespacesRemoveMaxConsumersPerTopicParameters -> ClientM NoContent
namespacesRemoveMaxConsumersPerTopic NamespacesRemoveMaxConsumersPerTopicParameters {..} = client (Proxy :: Proxy NamespacesRemoveMaxConsumersPerTopicAPI) (namespacesRemoveMaxConsumersPerTopicTenant) (namespacesRemoveMaxConsumersPerTopicNamespace)

-- ^ 
type NamespacesRemoveMaxProducersPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxProducersPerTopic" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveMaxProducersPerTopicParameters = NamespacesRemoveMaxProducersPerTopicParameters
  { namespacesRemoveMaxProducersPerTopicTenant :: Text -- ^ 
  , namespacesRemoveMaxProducersPerTopicNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveMaxProducersPerTopic :: NamespacesRemoveMaxProducersPerTopicParameters -> ClientM NoContent
namespacesRemoveMaxProducersPerTopic NamespacesRemoveMaxProducersPerTopicParameters {..} = client (Proxy :: Proxy NamespacesRemoveMaxProducersPerTopicAPI) (namespacesRemoveMaxProducersPerTopicTenant) (namespacesRemoveMaxProducersPerTopicNamespace)

-- ^ 
type NamespacesRemoveMaxSubscriptionsPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxSubscriptionsPerTopic" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveMaxSubscriptionsPerTopicParameters = NamespacesRemoveMaxSubscriptionsPerTopicParameters
  { namespacesRemoveMaxSubscriptionsPerTopicTenant :: Text -- ^ 
  , namespacesRemoveMaxSubscriptionsPerTopicNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveMaxSubscriptionsPerTopic :: NamespacesRemoveMaxSubscriptionsPerTopicParameters -> ClientM NoContent
namespacesRemoveMaxSubscriptionsPerTopic NamespacesRemoveMaxSubscriptionsPerTopicParameters {..} = client (Proxy :: Proxy NamespacesRemoveMaxSubscriptionsPerTopicAPI) (namespacesRemoveMaxSubscriptionsPerTopicTenant) (namespacesRemoveMaxSubscriptionsPerTopicNamespace)

-- ^ 
type NamespacesRemoveMaxTopicsPerNamespaceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxTopicsPerNamespace" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveMaxTopicsPerNamespaceParameters = NamespacesRemoveMaxTopicsPerNamespaceParameters
  { namespacesRemoveMaxTopicsPerNamespaceTenant :: Text -- ^ 
  , namespacesRemoveMaxTopicsPerNamespaceNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveMaxTopicsPerNamespace :: NamespacesRemoveMaxTopicsPerNamespaceParameters -> ClientM NoContent
namespacesRemoveMaxTopicsPerNamespace NamespacesRemoveMaxTopicsPerNamespaceParameters {..} = client (Proxy :: Proxy NamespacesRemoveMaxTopicsPerNamespaceAPI) (namespacesRemoveMaxTopicsPerNamespaceTenant) (namespacesRemoveMaxTopicsPerNamespaceNamespace)

-- ^ 
type NamespacesRemoveMaxUnackedmessagesPerConsumerAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxUnackedMessagesPerConsumer" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveMaxUnackedmessagesPerConsumerParameters = NamespacesRemoveMaxUnackedmessagesPerConsumerParameters
  { namespacesRemoveMaxUnackedmessagesPerConsumerTenant :: Text -- ^ 
  , namespacesRemoveMaxUnackedmessagesPerConsumerNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveMaxUnackedmessagesPerConsumer :: NamespacesRemoveMaxUnackedmessagesPerConsumerParameters -> ClientM NoContent
namespacesRemoveMaxUnackedmessagesPerConsumer NamespacesRemoveMaxUnackedmessagesPerConsumerParameters {..} = client (Proxy :: Proxy NamespacesRemoveMaxUnackedmessagesPerConsumerAPI) (namespacesRemoveMaxUnackedmessagesPerConsumerTenant) (namespacesRemoveMaxUnackedmessagesPerConsumerNamespace)

-- ^ 
type NamespacesRemoveMaxUnackedmessagesPerSubscriptionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxUnackedMessagesPerSubscription" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveMaxUnackedmessagesPerSubscriptionParameters = NamespacesRemoveMaxUnackedmessagesPerSubscriptionParameters
  { namespacesRemoveMaxUnackedmessagesPerSubscriptionTenant :: Text -- ^ 
  , namespacesRemoveMaxUnackedmessagesPerSubscriptionNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveMaxUnackedmessagesPerSubscription :: NamespacesRemoveMaxUnackedmessagesPerSubscriptionParameters -> ClientM NoContent
namespacesRemoveMaxUnackedmessagesPerSubscription NamespacesRemoveMaxUnackedmessagesPerSubscriptionParameters {..} = client (Proxy :: Proxy NamespacesRemoveMaxUnackedmessagesPerSubscriptionAPI) (namespacesRemoveMaxUnackedmessagesPerSubscriptionTenant) (namespacesRemoveMaxUnackedmessagesPerSubscriptionNamespace)

-- ^ 
type NamespacesRemoveNamespaceAntiAffinityGroupAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "antiAffinity" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveNamespaceAntiAffinityGroupParameters = NamespacesRemoveNamespaceAntiAffinityGroupParameters
  { namespacesRemoveNamespaceAntiAffinityGroupTenant :: Text -- ^ 
  , namespacesRemoveNamespaceAntiAffinityGroupNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveNamespaceAntiAffinityGroup :: NamespacesRemoveNamespaceAntiAffinityGroupParameters -> ClientM NoContent
namespacesRemoveNamespaceAntiAffinityGroup NamespacesRemoveNamespaceAntiAffinityGroupParameters {..} = client (Proxy :: Proxy NamespacesRemoveNamespaceAntiAffinityGroupAPI) (namespacesRemoveNamespaceAntiAffinityGroupTenant) (namespacesRemoveNamespaceAntiAffinityGroupNamespace)

-- ^ 
type NamespacesRemoveNamespaceEntryFiltersAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "entryFilters" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveNamespaceEntryFiltersParameters = NamespacesRemoveNamespaceEntryFiltersParameters
  { namespacesRemoveNamespaceEntryFiltersTenant :: Text -- ^ 
  , namespacesRemoveNamespaceEntryFiltersNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveNamespaceEntryFilters :: NamespacesRemoveNamespaceEntryFiltersParameters -> ClientM NoContent
namespacesRemoveNamespaceEntryFilters NamespacesRemoveNamespaceEntryFiltersParameters {..} = client (Proxy :: Proxy NamespacesRemoveNamespaceEntryFiltersAPI) (namespacesRemoveNamespaceEntryFiltersTenant) (namespacesRemoveNamespaceEntryFiltersNamespace)

-- ^ 
type NamespacesRemoveNamespaceMessageTTLAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "messageTTL" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveNamespaceMessageTTLParameters = NamespacesRemoveNamespaceMessageTTLParameters
  { namespacesRemoveNamespaceMessageTTLTenant :: Text -- ^ 
  , namespacesRemoveNamespaceMessageTTLNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveNamespaceMessageTTL :: NamespacesRemoveNamespaceMessageTTLParameters -> ClientM NoContent
namespacesRemoveNamespaceMessageTTL NamespacesRemoveNamespaceMessageTTLParameters {..} = client (Proxy :: Proxy NamespacesRemoveNamespaceMessageTTLAPI) (namespacesRemoveNamespaceMessageTTLTenant) (namespacesRemoveNamespaceMessageTTLNamespace)

-- ^ 
type NamespacesRemoveNamespaceResourceGroupAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "resourcegroup" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveNamespaceResourceGroupParameters = NamespacesRemoveNamespaceResourceGroupParameters
  { namespacesRemoveNamespaceResourceGroupTenant :: Text -- ^ 
  , namespacesRemoveNamespaceResourceGroupNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveNamespaceResourceGroup :: NamespacesRemoveNamespaceResourceGroupParameters -> ClientM NoContent
namespacesRemoveNamespaceResourceGroup NamespacesRemoveNamespaceResourceGroupParameters {..} = client (Proxy :: Proxy NamespacesRemoveNamespaceResourceGroupAPI) (namespacesRemoveNamespaceResourceGroupTenant) (namespacesRemoveNamespaceResourceGroupNamespace)

-- ^ 
type NamespacesRemoveOffloadPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "removeOffloadPolicies" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveOffloadPoliciesParameters = NamespacesRemoveOffloadPoliciesParameters
  { namespacesRemoveOffloadPoliciesTenant :: Text -- ^ 
  , namespacesRemoveOffloadPoliciesNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveOffloadPolicies :: NamespacesRemoveOffloadPoliciesParameters -> ClientM NoContent
namespacesRemoveOffloadPolicies NamespacesRemoveOffloadPoliciesParameters {..} = client (Proxy :: Proxy NamespacesRemoveOffloadPoliciesAPI) (namespacesRemoveOffloadPoliciesTenant) (namespacesRemoveOffloadPoliciesNamespace)

-- ^ 
type NamespacesRemovePropertyAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "property" :> Capture "key" Text :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemovePropertyParameters = NamespacesRemovePropertyParameters
  { namespacesRemovePropertyTenant :: Text -- ^ 
  , namespacesRemovePropertyNamespace :: Text -- ^ 
  , namespacesRemovePropertyKey :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveProperty :: NamespacesRemovePropertyParameters -> ClientM NoContent
namespacesRemoveProperty NamespacesRemovePropertyParameters {..} = client (Proxy :: Proxy NamespacesRemovePropertyAPI) (namespacesRemovePropertyTenant) (namespacesRemovePropertyNamespace) (namespacesRemovePropertyKey)

-- ^ 
type NamespacesRemoveReplicatorDispatchRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "replicatorDispatchRate" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveReplicatorDispatchRateParameters = NamespacesRemoveReplicatorDispatchRateParameters
  { namespacesRemoveReplicatorDispatchRateTenant :: Text -- ^ 
  , namespacesRemoveReplicatorDispatchRateNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveReplicatorDispatchRate :: NamespacesRemoveReplicatorDispatchRateParameters -> ClientM NoContent
namespacesRemoveReplicatorDispatchRate NamespacesRemoveReplicatorDispatchRateParameters {..} = client (Proxy :: Proxy NamespacesRemoveReplicatorDispatchRateAPI) (namespacesRemoveReplicatorDispatchRateTenant) (namespacesRemoveReplicatorDispatchRateNamespace)

-- ^ 
type NamespacesRemoveRetentionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "retention" :> ReqBody '[JSON] RetentionPolicies :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveRetentionParameters = NamespacesRemoveRetentionParameters
  { namespacesRemoveRetentionTenant :: Text -- ^ 
  , namespacesRemoveRetentionNamespace :: Text -- ^ 
  , namespacesRemoveRetentionBody :: RetentionPolicies -- ^ Retention policies for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesRemoveRetention :: NamespacesRemoveRetentionParameters -> ClientM NoContent
namespacesRemoveRetention NamespacesRemoveRetentionParameters {..} = client (Proxy :: Proxy NamespacesRemoveRetentionAPI) (namespacesRemoveRetentionTenant) (namespacesRemoveRetentionNamespace) namespacesRemoveRetentionBody

-- ^ 
type NamespacesRemoveSubscriptionExpirationTimeAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionExpirationTime" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveSubscriptionExpirationTimeParameters = NamespacesRemoveSubscriptionExpirationTimeParameters
  { namespacesRemoveSubscriptionExpirationTimeTenant :: Text -- ^ 
  , namespacesRemoveSubscriptionExpirationTimeNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveSubscriptionExpirationTime :: NamespacesRemoveSubscriptionExpirationTimeParameters -> ClientM NoContent
namespacesRemoveSubscriptionExpirationTime NamespacesRemoveSubscriptionExpirationTimeParameters {..} = client (Proxy :: Proxy NamespacesRemoveSubscriptionExpirationTimeAPI) (namespacesRemoveSubscriptionExpirationTimeTenant) (namespacesRemoveSubscriptionExpirationTimeNamespace)

-- ^ 
type NamespacesRemoveSubscriptionTypesEnabledAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionTypesEnabled" :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRemoveSubscriptionTypesEnabledParameters = NamespacesRemoveSubscriptionTypesEnabledParameters
  { namespacesRemoveSubscriptionTypesEnabledTenant :: Text -- ^ 
  , namespacesRemoveSubscriptionTypesEnabledNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRemoveSubscriptionTypesEnabled :: NamespacesRemoveSubscriptionTypesEnabledParameters -> ClientM NoContent
namespacesRemoveSubscriptionTypesEnabled NamespacesRemoveSubscriptionTypesEnabledParameters {..} = client (Proxy :: Proxy NamespacesRemoveSubscriptionTypesEnabledAPI) (namespacesRemoveSubscriptionTypesEnabledTenant) (namespacesRemoveSubscriptionTypesEnabledNamespace)

-- ^ 
type NamespacesRevokePermissionsOnNamespaceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "permissions" :> Capture "role" Text :> Verb 'DELETE 200 '[JSON] NoContent

data NamespacesRevokePermissionsOnNamespaceParameters = NamespacesRevokePermissionsOnNamespaceParameters
  { namespacesRevokePermissionsOnNamespaceTenant :: Text -- ^ 
  , namespacesRevokePermissionsOnNamespaceNamespace :: Text -- ^ 
  , namespacesRevokePermissionsOnNamespaceRole :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesRevokePermissionsOnNamespace :: NamespacesRevokePermissionsOnNamespaceParameters -> ClientM NoContent
namespacesRevokePermissionsOnNamespace NamespacesRevokePermissionsOnNamespaceParameters {..} = client (Proxy :: Proxy NamespacesRevokePermissionsOnNamespaceAPI) (namespacesRevokePermissionsOnNamespaceTenant) (namespacesRevokePermissionsOnNamespaceNamespace) (namespacesRevokePermissionsOnNamespaceRole)

-- ^ 
type NamespacesRevokePermissionsOnTopicsAPI =
      "admin" :> "v2" :> "namespaces" :> "revokePermissionsOnTopics" :> Verb 'POST 200 '[JSON] NoContent

namespacesRevokePermissionsOnTopics :: ClientM NoContent
namespacesRevokePermissionsOnTopics = client (Proxy :: Proxy NamespacesRevokePermissionsOnTopicsAPI)

-- ^ 
type NamespacesScanOffloadedLedgersAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "scanOffloadedLedgers" :> Verb 'GET 200 '[JSON] NoContent

data NamespacesScanOffloadedLedgersParameters = NamespacesScanOffloadedLedgersParameters
  { namespacesScanOffloadedLedgersTenant :: Text -- ^ 
  , namespacesScanOffloadedLedgersNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesScanOffloadedLedgers :: NamespacesScanOffloadedLedgersParameters -> ClientM NoContent
namespacesScanOffloadedLedgers NamespacesScanOffloadedLedgersParameters {..} = client (Proxy :: Proxy NamespacesScanOffloadedLedgersAPI) (namespacesScanOffloadedLedgersTenant) (namespacesScanOffloadedLedgersNamespace)

-- ^ 
type NamespacesSetAutoSubscriptionCreationAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "autoSubscriptionCreation" :> ReqBody '[JSON] AutoSubscriptionCreationOverride :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetAutoSubscriptionCreationParameters = NamespacesSetAutoSubscriptionCreationParameters
  { namespacesSetAutoSubscriptionCreationTenant :: Text -- ^ 
  , namespacesSetAutoSubscriptionCreationNamespace :: Text -- ^ 
  , namespacesSetAutoSubscriptionCreationBody :: AutoSubscriptionCreationOverride -- ^ Settings for automatic subscription creation
  } deriving (Show, Eq, Generic)

namespacesSetAutoSubscriptionCreation :: NamespacesSetAutoSubscriptionCreationParameters -> ClientM NoContent
namespacesSetAutoSubscriptionCreation NamespacesSetAutoSubscriptionCreationParameters {..} = client (Proxy :: Proxy NamespacesSetAutoSubscriptionCreationAPI) (namespacesSetAutoSubscriptionCreationTenant) (namespacesSetAutoSubscriptionCreationNamespace) namespacesSetAutoSubscriptionCreationBody

-- ^ 
type NamespacesSetAutoTopicCreationAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "autoTopicCreation" :> ReqBody '[JSON] AutoTopicCreationOverride :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetAutoTopicCreationParameters = NamespacesSetAutoTopicCreationParameters
  { namespacesSetAutoTopicCreationTenant :: Text -- ^ 
  , namespacesSetAutoTopicCreationNamespace :: Text -- ^ 
  , namespacesSetAutoTopicCreationBody :: AutoTopicCreationOverride -- ^ Settings for automatic topic creation
  } deriving (Show, Eq, Generic)

namespacesSetAutoTopicCreation :: NamespacesSetAutoTopicCreationParameters -> ClientM NoContent
namespacesSetAutoTopicCreation NamespacesSetAutoTopicCreationParameters {..} = client (Proxy :: Proxy NamespacesSetAutoTopicCreationAPI) (namespacesSetAutoTopicCreationTenant) (namespacesSetAutoTopicCreationNamespace) namespacesSetAutoTopicCreationBody

-- ^ 
type NamespacesSetBacklogQuotaAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "backlogQuota" :> QueryParam "backlogQuotaType" Text :> ReqBody '[JSON] BacklogQuota :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetBacklogQuotaParameters = NamespacesSetBacklogQuotaParameters
  { namespacesSetBacklogQuotaTenant :: Text -- ^ 
  , namespacesSetBacklogQuotaNamespace :: Text -- ^ 
  , namespacesSetBacklogQuotaBacklogQuotaType :: Maybe Text -- ^ 
  , namespacesSetBacklogQuotaBody :: BacklogQuota -- ^ Backlog quota for all topics of the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetBacklogQuota :: NamespacesSetBacklogQuotaParameters -> ClientM NoContent
namespacesSetBacklogQuota NamespacesSetBacklogQuotaParameters {..} = client (Proxy :: Proxy NamespacesSetBacklogQuotaAPI) (namespacesSetBacklogQuotaTenant) (namespacesSetBacklogQuotaNamespace) (namespacesSetBacklogQuotaBacklogQuotaType) namespacesSetBacklogQuotaBody

-- ^ 
type NamespacesSetBookieAffinityGroupAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "persistence" :> "bookieAffinity" :> ReqBody '[JSON] BookieAffinityGroupData :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetBookieAffinityGroupParameters = NamespacesSetBookieAffinityGroupParameters
  { namespacesSetBookieAffinityGroupTenant :: Text -- ^ 
  , namespacesSetBookieAffinityGroupNamespace :: Text -- ^ 
  , namespacesSetBookieAffinityGroupBody :: BookieAffinityGroupData -- ^ Bookie affinity group for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetBookieAffinityGroup :: NamespacesSetBookieAffinityGroupParameters -> ClientM NoContent
namespacesSetBookieAffinityGroup NamespacesSetBookieAffinityGroupParameters {..} = client (Proxy :: Proxy NamespacesSetBookieAffinityGroupAPI) (namespacesSetBookieAffinityGroupTenant) (namespacesSetBookieAffinityGroupNamespace) namespacesSetBookieAffinityGroupBody

-- ^ The backlog size is compared to the threshold periodically. A threshold of 0 disabled automatic compaction
type NamespacesSetCompactionThresholdAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "compactionThreshold" :> ReqBody '[JSON] Integer :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesSetCompactionThresholdParameters = NamespacesSetCompactionThresholdParameters
  { namespacesSetCompactionThresholdTenant :: Text -- ^ 
  , namespacesSetCompactionThresholdNamespace :: Text -- ^ 
  , namespacesSetCompactionThresholdBody :: Integer -- ^ Maximum number of uncompacted bytes in a topic of the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetCompactionThreshold :: NamespacesSetCompactionThresholdParameters -> ClientM NoContent
namespacesSetCompactionThreshold NamespacesSetCompactionThresholdParameters {..} = client (Proxy :: Proxy NamespacesSetCompactionThresholdAPI) (namespacesSetCompactionThresholdTenant) (namespacesSetCompactionThresholdNamespace) namespacesSetCompactionThresholdBody

-- ^ 
type NamespacesSetDeduplicationSnapshotIntervalAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "deduplicationSnapshotInterval" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetDeduplicationSnapshotIntervalParameters = NamespacesSetDeduplicationSnapshotIntervalParameters
  { namespacesSetDeduplicationSnapshotIntervalTenant :: Text -- ^ 
  , namespacesSetDeduplicationSnapshotIntervalNamespace :: Text -- ^ 
  , namespacesSetDeduplicationSnapshotIntervalBody :: Int -- ^ Interval to take deduplication snapshot per topic
  } deriving (Show, Eq, Generic)

namespacesSetDeduplicationSnapshotInterval :: NamespacesSetDeduplicationSnapshotIntervalParameters -> ClientM NoContent
namespacesSetDeduplicationSnapshotInterval NamespacesSetDeduplicationSnapshotIntervalParameters {..} = client (Proxy :: Proxy NamespacesSetDeduplicationSnapshotIntervalAPI) (namespacesSetDeduplicationSnapshotIntervalTenant) (namespacesSetDeduplicationSnapshotIntervalNamespace) namespacesSetDeduplicationSnapshotIntervalBody

-- ^ 
type NamespacesSetDelayedDeliveryPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "delayedDelivery" :> ReqBody '[JSON] DelayedDeliveryPolicies :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetDelayedDeliveryPoliciesParameters = NamespacesSetDelayedDeliveryPoliciesParameters
  { namespacesSetDelayedDeliveryPoliciesTenant :: Text -- ^ 
  , namespacesSetDelayedDeliveryPoliciesNamespace :: Text -- ^ 
  , namespacesSetDelayedDeliveryPoliciesBody :: DelayedDeliveryPolicies -- ^ Delayed delivery policies for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetDelayedDeliveryPolicies :: NamespacesSetDelayedDeliveryPoliciesParameters -> ClientM NoContent
namespacesSetDelayedDeliveryPolicies NamespacesSetDelayedDeliveryPoliciesParameters {..} = client (Proxy :: Proxy NamespacesSetDelayedDeliveryPoliciesAPI) (namespacesSetDelayedDeliveryPoliciesTenant) (namespacesSetDelayedDeliveryPoliciesNamespace) namespacesSetDelayedDeliveryPoliciesBody

-- ^ 
type NamespacesSetDispatchRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "dispatchRate" :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetDispatchRateParameters = NamespacesSetDispatchRateParameters
  { namespacesSetDispatchRateTenant :: Text -- ^ 
  , namespacesSetDispatchRateNamespace :: Text -- ^ 
  , namespacesSetDispatchRateBody :: DispatchRateImpl -- ^ Dispatch rate for all topics of the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetDispatchRate :: NamespacesSetDispatchRateParameters -> ClientM NoContent
namespacesSetDispatchRate NamespacesSetDispatchRateParameters {..} = client (Proxy :: Proxy NamespacesSetDispatchRateAPI) (namespacesSetDispatchRateTenant) (namespacesSetDispatchRateNamespace) namespacesSetDispatchRateBody

-- ^ 
type NamespacesSetDispatcherPauseOnAckStatePersistentAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "dispatcherPauseOnAckStatePersistent" :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetDispatcherPauseOnAckStatePersistentParameters = NamespacesSetDispatcherPauseOnAckStatePersistentParameters
  { namespacesSetDispatcherPauseOnAckStatePersistentTenant :: Text -- ^ 
  , namespacesSetDispatcherPauseOnAckStatePersistentNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesSetDispatcherPauseOnAckStatePersistent :: NamespacesSetDispatcherPauseOnAckStatePersistentParameters -> ClientM NoContent
namespacesSetDispatcherPauseOnAckStatePersistent NamespacesSetDispatcherPauseOnAckStatePersistentParameters {..} = client (Proxy :: Proxy NamespacesSetDispatcherPauseOnAckStatePersistentAPI) (namespacesSetDispatcherPauseOnAckStatePersistentTenant) (namespacesSetDispatcherPauseOnAckStatePersistentNamespace)

-- ^ 
type NamespacesSetEntryFiltersPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "entryFilters" :> ReqBody '[JSON] EntryFilters :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetEntryFiltersPerTopicParameters = NamespacesSetEntryFiltersPerTopicParameters
  { namespacesSetEntryFiltersPerTopicTenant :: Text -- ^ 
  , namespacesSetEntryFiltersPerTopicNamespace :: Text -- ^ 
  , namespacesSetEntryFiltersPerTopicBody :: EntryFilters -- ^ entry filters
  } deriving (Show, Eq, Generic)

namespacesSetEntryFiltersPerTopic :: NamespacesSetEntryFiltersPerTopicParameters -> ClientM NoContent
namespacesSetEntryFiltersPerTopic NamespacesSetEntryFiltersPerTopicParameters {..} = client (Proxy :: Proxy NamespacesSetEntryFiltersPerTopicAPI) (namespacesSetEntryFiltersPerTopicTenant) (namespacesSetEntryFiltersPerTopicNamespace) namespacesSetEntryFiltersPerTopicBody

-- ^ 
type NamespacesSetInactiveTopicPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "inactiveTopicPolicies" :> ReqBody '[JSON] InactiveTopicPolicies :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetInactiveTopicPoliciesParameters = NamespacesSetInactiveTopicPoliciesParameters
  { namespacesSetInactiveTopicPoliciesTenant :: Text -- ^ 
  , namespacesSetInactiveTopicPoliciesNamespace :: Text -- ^ 
  , namespacesSetInactiveTopicPoliciesBody :: InactiveTopicPolicies -- ^ Inactive topic policies for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetInactiveTopicPolicies :: NamespacesSetInactiveTopicPoliciesParameters -> ClientM NoContent
namespacesSetInactiveTopicPolicies NamespacesSetInactiveTopicPoliciesParameters {..} = client (Proxy :: Proxy NamespacesSetInactiveTopicPoliciesAPI) (namespacesSetInactiveTopicPoliciesTenant) (namespacesSetInactiveTopicPoliciesNamespace) namespacesSetInactiveTopicPoliciesBody

-- ^ 
type NamespacesSetIsAllowAutoUpdateSchemaAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "isAllowAutoUpdateSchema" :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetIsAllowAutoUpdateSchemaParameters = NamespacesSetIsAllowAutoUpdateSchemaParameters
  { namespacesSetIsAllowAutoUpdateSchemaTenant :: Text -- ^ 
  , namespacesSetIsAllowAutoUpdateSchemaNamespace :: Text -- ^ 
  , namespacesSetIsAllowAutoUpdateSchemaBody :: Bool -- ^ Flag of whether to allow auto update schema
  } deriving (Show, Eq, Generic)

namespacesSetIsAllowAutoUpdateSchema :: NamespacesSetIsAllowAutoUpdateSchemaParameters -> ClientM NoContent
namespacesSetIsAllowAutoUpdateSchema NamespacesSetIsAllowAutoUpdateSchemaParameters {..} = client (Proxy :: Proxy NamespacesSetIsAllowAutoUpdateSchemaAPI) (namespacesSetIsAllowAutoUpdateSchemaTenant) (namespacesSetIsAllowAutoUpdateSchemaNamespace) namespacesSetIsAllowAutoUpdateSchemaBody

-- ^ 
type NamespacesSetMaxConsumersPerSubscriptionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxConsumersPerSubscription" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetMaxConsumersPerSubscriptionParameters = NamespacesSetMaxConsumersPerSubscriptionParameters
  { namespacesSetMaxConsumersPerSubscriptionTenant :: Text -- ^ 
  , namespacesSetMaxConsumersPerSubscriptionNamespace :: Text -- ^ 
  , namespacesSetMaxConsumersPerSubscriptionBody :: Int -- ^ Number of maximum consumers per subscription
  } deriving (Show, Eq, Generic)

namespacesSetMaxConsumersPerSubscription :: NamespacesSetMaxConsumersPerSubscriptionParameters -> ClientM NoContent
namespacesSetMaxConsumersPerSubscription NamespacesSetMaxConsumersPerSubscriptionParameters {..} = client (Proxy :: Proxy NamespacesSetMaxConsumersPerSubscriptionAPI) (namespacesSetMaxConsumersPerSubscriptionTenant) (namespacesSetMaxConsumersPerSubscriptionNamespace) namespacesSetMaxConsumersPerSubscriptionBody

-- ^ 
type NamespacesSetMaxConsumersPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxConsumersPerTopic" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetMaxConsumersPerTopicParameters = NamespacesSetMaxConsumersPerTopicParameters
  { namespacesSetMaxConsumersPerTopicTenant :: Text -- ^ 
  , namespacesSetMaxConsumersPerTopicNamespace :: Text -- ^ 
  , namespacesSetMaxConsumersPerTopicBody :: Int -- ^ Number of maximum consumers per topic
  } deriving (Show, Eq, Generic)

namespacesSetMaxConsumersPerTopic :: NamespacesSetMaxConsumersPerTopicParameters -> ClientM NoContent
namespacesSetMaxConsumersPerTopic NamespacesSetMaxConsumersPerTopicParameters {..} = client (Proxy :: Proxy NamespacesSetMaxConsumersPerTopicAPI) (namespacesSetMaxConsumersPerTopicTenant) (namespacesSetMaxConsumersPerTopicNamespace) namespacesSetMaxConsumersPerTopicBody

-- ^ 
type NamespacesSetMaxProducersPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxProducersPerTopic" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetMaxProducersPerTopicParameters = NamespacesSetMaxProducersPerTopicParameters
  { namespacesSetMaxProducersPerTopicTenant :: Text -- ^ 
  , namespacesSetMaxProducersPerTopicNamespace :: Text -- ^ 
  , namespacesSetMaxProducersPerTopicBody :: Int -- ^ Number of maximum producers per topic
  } deriving (Show, Eq, Generic)

namespacesSetMaxProducersPerTopic :: NamespacesSetMaxProducersPerTopicParameters -> ClientM NoContent
namespacesSetMaxProducersPerTopic NamespacesSetMaxProducersPerTopicParameters {..} = client (Proxy :: Proxy NamespacesSetMaxProducersPerTopicAPI) (namespacesSetMaxProducersPerTopicTenant) (namespacesSetMaxProducersPerTopicNamespace) namespacesSetMaxProducersPerTopicBody

-- ^ 
type NamespacesSetMaxSubscriptionsPerTopicAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxSubscriptionsPerTopic" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetMaxSubscriptionsPerTopicParameters = NamespacesSetMaxSubscriptionsPerTopicParameters
  { namespacesSetMaxSubscriptionsPerTopicTenant :: Text -- ^ 
  , namespacesSetMaxSubscriptionsPerTopicNamespace :: Text -- ^ 
  , namespacesSetMaxSubscriptionsPerTopicBody :: Int -- ^ Number of maximum subscriptions per topic
  } deriving (Show, Eq, Generic)

namespacesSetMaxSubscriptionsPerTopic :: NamespacesSetMaxSubscriptionsPerTopicParameters -> ClientM NoContent
namespacesSetMaxSubscriptionsPerTopic NamespacesSetMaxSubscriptionsPerTopicParameters {..} = client (Proxy :: Proxy NamespacesSetMaxSubscriptionsPerTopicAPI) (namespacesSetMaxSubscriptionsPerTopicTenant) (namespacesSetMaxSubscriptionsPerTopicNamespace) namespacesSetMaxSubscriptionsPerTopicBody

-- ^ 
type NamespacesSetMaxTopicsPerNamespaceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxTopicsPerNamespace" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetMaxTopicsPerNamespaceParameters = NamespacesSetMaxTopicsPerNamespaceParameters
  { namespacesSetMaxTopicsPerNamespaceTenant :: Text -- ^ 
  , namespacesSetMaxTopicsPerNamespaceNamespace :: Text -- ^ 
  , namespacesSetMaxTopicsPerNamespaceBody :: Int -- ^ Number of maximum topics for specific namespace
  } deriving (Show, Eq, Generic)

namespacesSetMaxTopicsPerNamespace :: NamespacesSetMaxTopicsPerNamespaceParameters -> ClientM NoContent
namespacesSetMaxTopicsPerNamespace NamespacesSetMaxTopicsPerNamespaceParameters {..} = client (Proxy :: Proxy NamespacesSetMaxTopicsPerNamespaceAPI) (namespacesSetMaxTopicsPerNamespaceTenant) (namespacesSetMaxTopicsPerNamespaceNamespace) namespacesSetMaxTopicsPerNamespaceBody

-- ^ 
type NamespacesSetMaxUnackedMessagesPerConsumerAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxUnackedMessagesPerConsumer" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetMaxUnackedMessagesPerConsumerParameters = NamespacesSetMaxUnackedMessagesPerConsumerParameters
  { namespacesSetMaxUnackedMessagesPerConsumerTenant :: Text -- ^ 
  , namespacesSetMaxUnackedMessagesPerConsumerNamespace :: Text -- ^ 
  , namespacesSetMaxUnackedMessagesPerConsumerBody :: Int -- ^ Number of maximum unacked messages per consumer
  } deriving (Show, Eq, Generic)

namespacesSetMaxUnackedMessagesPerConsumer :: NamespacesSetMaxUnackedMessagesPerConsumerParameters -> ClientM NoContent
namespacesSetMaxUnackedMessagesPerConsumer NamespacesSetMaxUnackedMessagesPerConsumerParameters {..} = client (Proxy :: Proxy NamespacesSetMaxUnackedMessagesPerConsumerAPI) (namespacesSetMaxUnackedMessagesPerConsumerTenant) (namespacesSetMaxUnackedMessagesPerConsumerNamespace) namespacesSetMaxUnackedMessagesPerConsumerBody

-- ^ 
type NamespacesSetMaxUnackedMessagesPerSubscriptionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "maxUnackedMessagesPerSubscription" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetMaxUnackedMessagesPerSubscriptionParameters = NamespacesSetMaxUnackedMessagesPerSubscriptionParameters
  { namespacesSetMaxUnackedMessagesPerSubscriptionTenant :: Text -- ^ 
  , namespacesSetMaxUnackedMessagesPerSubscriptionNamespace :: Text -- ^ 
  , namespacesSetMaxUnackedMessagesPerSubscriptionBody :: Int -- ^ Number of maximum unacked messages per subscription
  } deriving (Show, Eq, Generic)

namespacesSetMaxUnackedMessagesPerSubscription :: NamespacesSetMaxUnackedMessagesPerSubscriptionParameters -> ClientM NoContent
namespacesSetMaxUnackedMessagesPerSubscription NamespacesSetMaxUnackedMessagesPerSubscriptionParameters {..} = client (Proxy :: Proxy NamespacesSetMaxUnackedMessagesPerSubscriptionAPI) (namespacesSetMaxUnackedMessagesPerSubscriptionTenant) (namespacesSetMaxUnackedMessagesPerSubscriptionNamespace) namespacesSetMaxUnackedMessagesPerSubscriptionBody

-- ^ 
type NamespacesSetNamespaceAllowedClustersAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "allowedClusters" :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetNamespaceAllowedClustersParameters = NamespacesSetNamespaceAllowedClustersParameters
  { namespacesSetNamespaceAllowedClustersTenant :: Text -- ^ 
  , namespacesSetNamespaceAllowedClustersNamespace :: Text -- ^ 
  , namespacesSetNamespaceAllowedClustersBody :: [Text] -- ^ List of allowed clusters
  } deriving (Show, Eq, Generic)

namespacesSetNamespaceAllowedClusters :: NamespacesSetNamespaceAllowedClustersParameters -> ClientM NoContent
namespacesSetNamespaceAllowedClusters NamespacesSetNamespaceAllowedClustersParameters {..} = client (Proxy :: Proxy NamespacesSetNamespaceAllowedClustersAPI) (namespacesSetNamespaceAllowedClustersTenant) (namespacesSetNamespaceAllowedClustersNamespace) namespacesSetNamespaceAllowedClustersBody

-- ^ 
type NamespacesSetNamespaceAntiAffinityGroupAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "antiAffinity" :> ReqBody '[JSON] Text :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetNamespaceAntiAffinityGroupParameters = NamespacesSetNamespaceAntiAffinityGroupParameters
  { namespacesSetNamespaceAntiAffinityGroupTenant :: Text -- ^ 
  , namespacesSetNamespaceAntiAffinityGroupNamespace :: Text -- ^ 
  , namespacesSetNamespaceAntiAffinityGroupBody :: Text -- ^ Anti-affinity group for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetNamespaceAntiAffinityGroup :: NamespacesSetNamespaceAntiAffinityGroupParameters -> ClientM NoContent
namespacesSetNamespaceAntiAffinityGroup NamespacesSetNamespaceAntiAffinityGroupParameters {..} = client (Proxy :: Proxy NamespacesSetNamespaceAntiAffinityGroupAPI) (namespacesSetNamespaceAntiAffinityGroupTenant) (namespacesSetNamespaceAntiAffinityGroupNamespace) namespacesSetNamespaceAntiAffinityGroupBody

-- ^ 
type NamespacesSetNamespaceMessageTTLAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "messageTTL" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetNamespaceMessageTTLParameters = NamespacesSetNamespaceMessageTTLParameters
  { namespacesSetNamespaceMessageTTLTenant :: Text -- ^ 
  , namespacesSetNamespaceMessageTTLNamespace :: Text -- ^ 
  , namespacesSetNamespaceMessageTTLBody :: Int -- ^ TTL in seconds for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetNamespaceMessageTTL :: NamespacesSetNamespaceMessageTTLParameters -> ClientM NoContent
namespacesSetNamespaceMessageTTL NamespacesSetNamespaceMessageTTLParameters {..} = client (Proxy :: Proxy NamespacesSetNamespaceMessageTTLAPI) (namespacesSetNamespaceMessageTTLTenant) (namespacesSetNamespaceMessageTTLNamespace) namespacesSetNamespaceMessageTTLBody

-- ^ 
type NamespacesSetNamespaceReplicationClustersAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "replication" :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetNamespaceReplicationClustersParameters = NamespacesSetNamespaceReplicationClustersParameters
  { namespacesSetNamespaceReplicationClustersTenant :: Text -- ^ 
  , namespacesSetNamespaceReplicationClustersNamespace :: Text -- ^ 
  , namespacesSetNamespaceReplicationClustersBody :: [Text] -- ^ List of replication clusters
  } deriving (Show, Eq, Generic)

namespacesSetNamespaceReplicationClusters :: NamespacesSetNamespaceReplicationClustersParameters -> ClientM NoContent
namespacesSetNamespaceReplicationClusters NamespacesSetNamespaceReplicationClustersParameters {..} = client (Proxy :: Proxy NamespacesSetNamespaceReplicationClustersAPI) (namespacesSetNamespaceReplicationClustersTenant) (namespacesSetNamespaceReplicationClustersNamespace) namespacesSetNamespaceReplicationClustersBody

-- ^ 
type NamespacesSetNamespaceResourceGroupAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "resourcegroup" :> Capture "resourcegroup" Text :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetNamespaceResourceGroupParameters = NamespacesSetNamespaceResourceGroupParameters
  { namespacesSetNamespaceResourceGroupTenant :: Text -- ^ 
  , namespacesSetNamespaceResourceGroupNamespace :: Text -- ^ 
  , namespacesSetNamespaceResourceGroupResourcegroup :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesSetNamespaceResourceGroup :: NamespacesSetNamespaceResourceGroupParameters -> ClientM NoContent
namespacesSetNamespaceResourceGroup NamespacesSetNamespaceResourceGroupParameters {..} = client (Proxy :: Proxy NamespacesSetNamespaceResourceGroupAPI) (namespacesSetNamespaceResourceGroupTenant) (namespacesSetNamespaceResourceGroupNamespace) (namespacesSetNamespaceResourceGroupResourcegroup)

-- ^ A negative value disables the deletion completely.
type NamespacesSetOffloadDeletionLagAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "offloadDeletionLagMs" :> ReqBody '[JSON] Integer :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesSetOffloadDeletionLagParameters = NamespacesSetOffloadDeletionLagParameters
  { namespacesSetOffloadDeletionLagTenant :: Text -- ^ 
  , namespacesSetOffloadDeletionLagNamespace :: Text -- ^ 
  , namespacesSetOffloadDeletionLagBody :: Integer -- ^ New number of milliseconds to wait before deleting a ledger segment which has been offloaded
  } deriving (Show, Eq, Generic)

namespacesSetOffloadDeletionLag :: NamespacesSetOffloadDeletionLagParameters -> ClientM NoContent
namespacesSetOffloadDeletionLag NamespacesSetOffloadDeletionLagParameters {..} = client (Proxy :: Proxy NamespacesSetOffloadDeletionLagAPI) (namespacesSetOffloadDeletionLagTenant) (namespacesSetOffloadDeletionLagNamespace) namespacesSetOffloadDeletionLagBody

-- ^ 
type NamespacesSetOffloadPoliciesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "offloadPolicies" :> ReqBody '[JSON] OffloadPoliciesImpl :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetOffloadPoliciesParameters = NamespacesSetOffloadPoliciesParameters
  { namespacesSetOffloadPoliciesTenant :: Text -- ^ 
  , namespacesSetOffloadPoliciesNamespace :: Text -- ^ 
  , namespacesSetOffloadPoliciesBody :: OffloadPoliciesImpl -- ^ Offload policies for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetOffloadPolicies :: NamespacesSetOffloadPoliciesParameters -> ClientM NoContent
namespacesSetOffloadPolicies NamespacesSetOffloadPoliciesParameters {..} = client (Proxy :: Proxy NamespacesSetOffloadPoliciesAPI) (namespacesSetOffloadPoliciesTenant) (namespacesSetOffloadPoliciesNamespace) namespacesSetOffloadPoliciesBody

-- ^ -1 will revert to using the cluster default. A negative value disables automatic offloading. 
type NamespacesSetOffloadThresholdAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "offloadThreshold" :> ReqBody '[JSON] Integer :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesSetOffloadThresholdParameters = NamespacesSetOffloadThresholdParameters
  { namespacesSetOffloadThresholdTenant :: Text -- ^ 
  , namespacesSetOffloadThresholdNamespace :: Text -- ^ 
  , namespacesSetOffloadThresholdBody :: Integer -- ^ Maximum number of bytes stored on the pulsar cluster for a topic of the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetOffloadThreshold :: NamespacesSetOffloadThresholdParameters -> ClientM NoContent
namespacesSetOffloadThreshold NamespacesSetOffloadThresholdParameters {..} = client (Proxy :: Proxy NamespacesSetOffloadThresholdAPI) (namespacesSetOffloadThresholdTenant) (namespacesSetOffloadThresholdNamespace) namespacesSetOffloadThresholdBody

-- ^ A negative value disables automatic offloading
type NamespacesSetOffloadThresholdInSecondsAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "offloadThresholdInSeconds" :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesSetOffloadThresholdInSecondsParameters = NamespacesSetOffloadThresholdInSecondsParameters
  { namespacesSetOffloadThresholdInSecondsTenant :: Text -- ^ 
  , namespacesSetOffloadThresholdInSecondsNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesSetOffloadThresholdInSeconds :: NamespacesSetOffloadThresholdInSecondsParameters -> ClientM NoContent
namespacesSetOffloadThresholdInSeconds NamespacesSetOffloadThresholdInSecondsParameters {..} = client (Proxy :: Proxy NamespacesSetOffloadThresholdInSecondsAPI) (namespacesSetOffloadThresholdInSecondsTenant) (namespacesSetOffloadThresholdInSecondsNamespace)

-- ^ 
type NamespacesSetPersistenceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "persistence" :> ReqBody '[JSON] PersistencePolicies :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetPersistenceParameters = NamespacesSetPersistenceParameters
  { namespacesSetPersistenceTenant :: Text -- ^ 
  , namespacesSetPersistenceNamespace :: Text -- ^ 
  , namespacesSetPersistenceBody :: PersistencePolicies -- ^ Persistence policies for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetPersistence :: NamespacesSetPersistenceParameters -> ClientM NoContent
namespacesSetPersistence NamespacesSetPersistenceParameters {..} = client (Proxy :: Proxy NamespacesSetPersistenceAPI) (namespacesSetPersistenceTenant) (namespacesSetPersistenceNamespace) namespacesSetPersistenceBody

-- ^ 
type NamespacesSetPropertiesAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "properties" :> ReqBody '[JSON] (Map.Map String Text) :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesSetPropertiesParameters = NamespacesSetPropertiesParameters
  { namespacesSetPropertiesTenant :: Text -- ^ 
  , namespacesSetPropertiesNamespace :: Text -- ^ 
  , namespacesSetPropertiesBody :: (Map.Map String Text) -- ^ Key value pair properties for the namespace
  } deriving (Show, Eq, Generic)

namespacesSetProperties :: NamespacesSetPropertiesParameters -> ClientM NoContent
namespacesSetProperties NamespacesSetPropertiesParameters {..} = client (Proxy :: Proxy NamespacesSetPropertiesAPI) (namespacesSetPropertiesTenant) (namespacesSetPropertiesNamespace) namespacesSetPropertiesBody

-- ^ 
type NamespacesSetPropertyAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "property" :> Capture "key" Text :> Capture "value" Text :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesSetPropertyParameters = NamespacesSetPropertyParameters
  { namespacesSetPropertyTenant :: Text -- ^ 
  , namespacesSetPropertyNamespace :: Text -- ^ 
  , namespacesSetPropertyKey :: Text -- ^ 
  , namespacesSetPropertyValue :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesSetProperty :: NamespacesSetPropertyParameters -> ClientM NoContent
namespacesSetProperty NamespacesSetPropertyParameters {..} = client (Proxy :: Proxy NamespacesSetPropertyAPI) (namespacesSetPropertyTenant) (namespacesSetPropertyNamespace) (namespacesSetPropertyKey) (namespacesSetPropertyValue)

-- ^ 
type NamespacesSetReplicatorDispatchRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "replicatorDispatchRate" :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetReplicatorDispatchRateParameters = NamespacesSetReplicatorDispatchRateParameters
  { namespacesSetReplicatorDispatchRateTenant :: Text -- ^ 
  , namespacesSetReplicatorDispatchRateNamespace :: Text -- ^ 
  , namespacesSetReplicatorDispatchRateBody :: DispatchRateImpl -- ^ Replicator dispatch rate for all topics of the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetReplicatorDispatchRate :: NamespacesSetReplicatorDispatchRateParameters -> ClientM NoContent
namespacesSetReplicatorDispatchRate NamespacesSetReplicatorDispatchRateParameters {..} = client (Proxy :: Proxy NamespacesSetReplicatorDispatchRateAPI) (namespacesSetReplicatorDispatchRateTenant) (namespacesSetReplicatorDispatchRateNamespace) namespacesSetReplicatorDispatchRateBody

-- ^ 
type NamespacesSetRetentionAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "retention" :> ReqBody '[JSON] RetentionPolicies :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetRetentionParameters = NamespacesSetRetentionParameters
  { namespacesSetRetentionTenant :: Text -- ^ 
  , namespacesSetRetentionNamespace :: Text -- ^ 
  , namespacesSetRetentionBody :: RetentionPolicies -- ^ Retention policies for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetRetention :: NamespacesSetRetentionParameters -> ClientM NoContent
namespacesSetRetention NamespacesSetRetentionParameters {..} = client (Proxy :: Proxy NamespacesSetRetentionAPI) (namespacesSetRetentionTenant) (namespacesSetRetentionNamespace) namespacesSetRetentionBody

-- ^ The value AutoUpdateDisabled prevents producers from updating the schema.  If set to AutoUpdateDisabled, schemas must be updated through the REST api
type NamespacesSetSchemaAutoUpdateCompatibilityStrategyAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "schemaAutoUpdateCompatibilityStrategy" :> ReqBody '[JSON] Text :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesSetSchemaAutoUpdateCompatibilityStrategyParameters = NamespacesSetSchemaAutoUpdateCompatibilityStrategyParameters
  { namespacesSetSchemaAutoUpdateCompatibilityStrategyTenant :: Text -- ^ 
  , namespacesSetSchemaAutoUpdateCompatibilityStrategyNamespace :: Text -- ^ 
  , namespacesSetSchemaAutoUpdateCompatibilityStrategyBody :: Text -- ^ Strategy used to check the compatibility of new schemas
  } deriving (Show, Eq, Generic)

namespacesSetSchemaAutoUpdateCompatibilityStrategy :: NamespacesSetSchemaAutoUpdateCompatibilityStrategyParameters -> ClientM NoContent
namespacesSetSchemaAutoUpdateCompatibilityStrategy NamespacesSetSchemaAutoUpdateCompatibilityStrategyParameters {..} = client (Proxy :: Proxy NamespacesSetSchemaAutoUpdateCompatibilityStrategyAPI) (namespacesSetSchemaAutoUpdateCompatibilityStrategyTenant) (namespacesSetSchemaAutoUpdateCompatibilityStrategyNamespace) namespacesSetSchemaAutoUpdateCompatibilityStrategyBody

-- ^ 
type NamespacesSetSchemaCompatibilityStrategyAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "schemaCompatibilityStrategy" :> ReqBody '[JSON] Text :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesSetSchemaCompatibilityStrategyParameters = NamespacesSetSchemaCompatibilityStrategyParameters
  { namespacesSetSchemaCompatibilityStrategyTenant :: Text -- ^ 
  , namespacesSetSchemaCompatibilityStrategyNamespace :: Text -- ^ 
  , namespacesSetSchemaCompatibilityStrategyBody :: Text -- ^ Strategy used to check the compatibility of new schema
  } deriving (Show, Eq, Generic)

namespacesSetSchemaCompatibilityStrategy :: NamespacesSetSchemaCompatibilityStrategyParameters -> ClientM NoContent
namespacesSetSchemaCompatibilityStrategy NamespacesSetSchemaCompatibilityStrategyParameters {..} = client (Proxy :: Proxy NamespacesSetSchemaCompatibilityStrategyAPI) (namespacesSetSchemaCompatibilityStrategyTenant) (namespacesSetSchemaCompatibilityStrategyNamespace) namespacesSetSchemaCompatibilityStrategyBody

-- ^ If the flag is set to true, when a producer without a schema attempts to produce to a topic with schema in this namespace, the producer will be failed to connect. PLEASE be carefully on using this, since non-java clients don't support schema.if you enable this setting, it will cause non-java clients failed to produce.
type NamespacesSetSchemaValidationEnforcedAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "schemaValidationEnforced" :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetSchemaValidationEnforcedParameters = NamespacesSetSchemaValidationEnforcedParameters
  { namespacesSetSchemaValidationEnforcedTenant :: Text -- ^ 
  , namespacesSetSchemaValidationEnforcedNamespace :: Text -- ^ 
  , namespacesSetSchemaValidationEnforcedBody :: Bool -- ^ Flag of whether validation is enforced on the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetSchemaValidationEnforced :: NamespacesSetSchemaValidationEnforcedParameters -> ClientM NoContent
namespacesSetSchemaValidationEnforced NamespacesSetSchemaValidationEnforcedParameters {..} = client (Proxy :: Proxy NamespacesSetSchemaValidationEnforcedAPI) (namespacesSetSchemaValidationEnforcedTenant) (namespacesSetSchemaValidationEnforcedNamespace) namespacesSetSchemaValidationEnforcedBody

-- ^ 
type NamespacesSetSubscribeRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscribeRate" :> ReqBody '[JSON] SubscribeRate :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetSubscribeRateParameters = NamespacesSetSubscribeRateParameters
  { namespacesSetSubscribeRateTenant :: Text -- ^ 
  , namespacesSetSubscribeRateNamespace :: Text -- ^ 
  , namespacesSetSubscribeRateBody :: SubscribeRate -- ^ Subscribe rate for all topics of the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetSubscribeRate :: NamespacesSetSubscribeRateParameters -> ClientM NoContent
namespacesSetSubscribeRate NamespacesSetSubscribeRateParameters {..} = client (Proxy :: Proxy NamespacesSetSubscribeRateAPI) (namespacesSetSubscribeRateTenant) (namespacesSetSubscribeRateNamespace) namespacesSetSubscribeRateBody

-- ^ 
type NamespacesSetSubscriptionAuthModeAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionAuthMode" :> ReqBody '[JSON] Text :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetSubscriptionAuthModeParameters = NamespacesSetSubscriptionAuthModeParameters
  { namespacesSetSubscriptionAuthModeTenant :: Text -- ^ 
  , namespacesSetSubscriptionAuthModeNamespace :: Text -- ^ 
  , namespacesSetSubscriptionAuthModeBody :: Text -- ^ Subscription auth mode for all topics of the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetSubscriptionAuthMode :: NamespacesSetSubscriptionAuthModeParameters -> ClientM NoContent
namespacesSetSubscriptionAuthMode NamespacesSetSubscriptionAuthModeParameters {..} = client (Proxy :: Proxy NamespacesSetSubscriptionAuthModeAPI) (namespacesSetSubscriptionAuthModeTenant) (namespacesSetSubscriptionAuthModeNamespace) namespacesSetSubscriptionAuthModeBody

-- ^ 
type NamespacesSetSubscriptionDispatchRateAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionDispatchRate" :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetSubscriptionDispatchRateParameters = NamespacesSetSubscriptionDispatchRateParameters
  { namespacesSetSubscriptionDispatchRateTenant :: Text -- ^ 
  , namespacesSetSubscriptionDispatchRateNamespace :: Text -- ^ 
  , namespacesSetSubscriptionDispatchRateBody :: DispatchRateImpl -- ^ Subscription dispatch rate for all topics of the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetSubscriptionDispatchRate :: NamespacesSetSubscriptionDispatchRateParameters -> ClientM NoContent
namespacesSetSubscriptionDispatchRate NamespacesSetSubscriptionDispatchRateParameters {..} = client (Proxy :: Proxy NamespacesSetSubscriptionDispatchRateAPI) (namespacesSetSubscriptionDispatchRateTenant) (namespacesSetSubscriptionDispatchRateNamespace) namespacesSetSubscriptionDispatchRateBody

-- ^ 
type NamespacesSetSubscriptionExpirationTimeAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionExpirationTime" :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetSubscriptionExpirationTimeParameters = NamespacesSetSubscriptionExpirationTimeParameters
  { namespacesSetSubscriptionExpirationTimeTenant :: Text -- ^ 
  , namespacesSetSubscriptionExpirationTimeNamespace :: Text -- ^ 
  , namespacesSetSubscriptionExpirationTimeBody :: Int -- ^ Expiration time in minutes for the specified namespace
  } deriving (Show, Eq, Generic)

namespacesSetSubscriptionExpirationTime :: NamespacesSetSubscriptionExpirationTimeParameters -> ClientM NoContent
namespacesSetSubscriptionExpirationTime NamespacesSetSubscriptionExpirationTimeParameters {..} = client (Proxy :: Proxy NamespacesSetSubscriptionExpirationTimeAPI) (namespacesSetSubscriptionExpirationTimeTenant) (namespacesSetSubscriptionExpirationTimeNamespace) namespacesSetSubscriptionExpirationTimeBody

-- ^ 
type NamespacesSetSubscriptionTypesEnabledAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "subscriptionTypesEnabled" :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data NamespacesSetSubscriptionTypesEnabledParameters = NamespacesSetSubscriptionTypesEnabledParameters
  { namespacesSetSubscriptionTypesEnabledTenant :: Text -- ^ 
  , namespacesSetSubscriptionTypesEnabledNamespace :: Text -- ^ 
  , namespacesSetSubscriptionTypesEnabledBody :: [Text] -- ^ Set of whether allow subscription types
  } deriving (Show, Eq, Generic)

namespacesSetSubscriptionTypesEnabled :: NamespacesSetSubscriptionTypesEnabledParameters -> ClientM NoContent
namespacesSetSubscriptionTypesEnabled NamespacesSetSubscriptionTypesEnabledParameters {..} = client (Proxy :: Proxy NamespacesSetSubscriptionTypesEnabledAPI) (namespacesSetSubscriptionTypesEnabledTenant) (namespacesSetSubscriptionTypesEnabledNamespace) namespacesSetSubscriptionTypesEnabledBody

-- ^ 
type NamespacesSplitNamespaceBundleAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> "split" :> QueryParam "authoritative" Bool :> QueryParam "unload" Bool :> QueryParam "splitAlgorithmName" Text :> ReqBody '[JSON] [Integer] :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesSplitNamespaceBundleParameters = NamespacesSplitNamespaceBundleParameters
  { namespacesSplitNamespaceBundleTenant :: Text -- ^ 
  , namespacesSplitNamespaceBundleNamespace :: Text -- ^ 
  , namespacesSplitNamespaceBundleBundle :: Text -- ^ 
  , namespacesSplitNamespaceBundleAuthoritative :: Maybe Bool -- ^ 
  , namespacesSplitNamespaceBundleUnload :: Maybe Bool -- ^ 
  , namespacesSplitNamespaceBundleSplitAlgorithmName :: Maybe Text -- ^ 
  , namespacesSplitNamespaceBundleBody :: [Integer] -- ^ splitBoundaries
  } deriving (Show, Eq, Generic)

namespacesSplitNamespaceBundle :: NamespacesSplitNamespaceBundleParameters -> ClientM NoContent
namespacesSplitNamespaceBundle NamespacesSplitNamespaceBundleParameters {..} = client (Proxy :: Proxy NamespacesSplitNamespaceBundleAPI) (namespacesSplitNamespaceBundleTenant) (namespacesSplitNamespaceBundleNamespace) (namespacesSplitNamespaceBundleBundle) (namespacesSplitNamespaceBundleAuthoritative) (namespacesSplitNamespaceBundleUnload) (namespacesSplitNamespaceBundleSplitAlgorithmName) namespacesSplitNamespaceBundleBody

-- ^ Unload an active namespace from the current broker serving it. Performing this operation will let the brokerremoves all producers, consumers, and connections using this namespace, and close all topics (includingtheir persistent store). During that operation, the namespace is marked as tentatively unavailable until thebroker completes the unloading action. This operation requires strictly super user privileges, since it wouldresult in non-persistent message loss and unexpected connection closure to the clients.
type NamespacesUnloadNamespaceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "unload" :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesUnloadNamespaceParameters = NamespacesUnloadNamespaceParameters
  { namespacesUnloadNamespaceTenant :: Text -- ^ 
  , namespacesUnloadNamespaceNamespace :: Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesUnloadNamespace :: NamespacesUnloadNamespaceParameters -> ClientM NoContent
namespacesUnloadNamespace NamespacesUnloadNamespaceParameters {..} = client (Proxy :: Proxy NamespacesUnloadNamespaceAPI) (namespacesUnloadNamespaceTenant) (namespacesUnloadNamespaceNamespace)

-- ^ 
type NamespacesUnloadNamespaceBundleAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> "unload" :> QueryParam "authoritative" Bool :> QueryParam "destinationBroker" Text :> Verb 'PUT 200 '[JSON] NoContent

data NamespacesUnloadNamespaceBundleParameters = NamespacesUnloadNamespaceBundleParameters
  { namespacesUnloadNamespaceBundleTenant :: Text -- ^ 
  , namespacesUnloadNamespaceBundleNamespace :: Text -- ^ 
  , namespacesUnloadNamespaceBundleBundle :: Text -- ^ 
  , namespacesUnloadNamespaceBundleAuthoritative :: Maybe Bool -- ^ 
  , namespacesUnloadNamespaceBundleDestinationBroker :: Maybe Text -- ^ 
  } deriving (Show, Eq, Generic)

namespacesUnloadNamespaceBundle :: NamespacesUnloadNamespaceBundleParameters -> ClientM NoContent
namespacesUnloadNamespaceBundle NamespacesUnloadNamespaceBundleParameters {..} = client (Proxy :: Proxy NamespacesUnloadNamespaceBundleAPI) (namespacesUnloadNamespaceBundleTenant) (namespacesUnloadNamespaceBundleNamespace) (namespacesUnloadNamespaceBundleBundle) (namespacesUnloadNamespaceBundleAuthoritative) (namespacesUnloadNamespaceBundleDestinationBroker)

-- ^ 
type NamespacesUnsubscribeNamespaceAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> "unsubscribe" :> Capture "subscription" Text :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesUnsubscribeNamespaceParameters = NamespacesUnsubscribeNamespaceParameters
  { namespacesUnsubscribeNamespaceTenant :: Text -- ^ 
  , namespacesUnsubscribeNamespaceNamespace :: Text -- ^ 
  , namespacesUnsubscribeNamespaceSubscription :: Text -- ^ 
  , namespacesUnsubscribeNamespaceAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

namespacesUnsubscribeNamespace :: NamespacesUnsubscribeNamespaceParameters -> ClientM NoContent
namespacesUnsubscribeNamespace NamespacesUnsubscribeNamespaceParameters {..} = client (Proxy :: Proxy NamespacesUnsubscribeNamespaceAPI) (namespacesUnsubscribeNamespaceTenant) (namespacesUnsubscribeNamespaceNamespace) (namespacesUnsubscribeNamespaceSubscription) (namespacesUnsubscribeNamespaceAuthoritative)

-- ^ 
type NamespacesUnsubscribeNamespaceBundleAPI =
      "admin" :> "v2" :> "namespaces" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> "unsubscribe" :> Capture "subscription" Text :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NamespacesUnsubscribeNamespaceBundleParameters = NamespacesUnsubscribeNamespaceBundleParameters
  { namespacesUnsubscribeNamespaceBundleTenant :: Text -- ^ 
  , namespacesUnsubscribeNamespaceBundleNamespace :: Text -- ^ 
  , namespacesUnsubscribeNamespaceBundleSubscription :: Text -- ^ 
  , namespacesUnsubscribeNamespaceBundleBundle :: Text -- ^ 
  , namespacesUnsubscribeNamespaceBundleAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

namespacesUnsubscribeNamespaceBundle :: NamespacesUnsubscribeNamespaceBundleParameters -> ClientM NoContent
namespacesUnsubscribeNamespaceBundle NamespacesUnsubscribeNamespaceBundleParameters {..} = client (Proxy :: Proxy NamespacesUnsubscribeNamespaceBundleAPI) (namespacesUnsubscribeNamespaceBundleTenant) (namespacesUnsubscribeNamespaceBundleNamespace) (namespacesUnsubscribeNamespaceBundleSubscription) (namespacesUnsubscribeNamespaceBundleBundle) (namespacesUnsubscribeNamespaceBundleAuthoritative)

-- ^ 
type NonPersistentTopicsAnalyzeSubscriptionBacklogAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "analyzeBacklog" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] ResetCursorData :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsAnalyzeSubscriptionBacklogParameters = NonPersistentTopicsAnalyzeSubscriptionBacklogParameters
  { nonPersistentTopicsAnalyzeSubscriptionBacklogTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsAnalyzeSubscriptionBacklogNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsAnalyzeSubscriptionBacklogTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsAnalyzeSubscriptionBacklogSubName :: Text -- ^ Subscription
  , nonPersistentTopicsAnalyzeSubscriptionBacklogAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsAnalyzeSubscriptionBacklogPosition :: ResetCursorData -- ^ messageId to start the analysis
  } deriving (Show, Eq, Generic)

nonPersistentTopicsAnalyzeSubscriptionBacklog :: NonPersistentTopicsAnalyzeSubscriptionBacklogParameters -> ClientM NoContent
nonPersistentTopicsAnalyzeSubscriptionBacklog NonPersistentTopicsAnalyzeSubscriptionBacklogParameters {..} = client (Proxy :: Proxy NonPersistentTopicsAnalyzeSubscriptionBacklogAPI) (nonPersistentTopicsAnalyzeSubscriptionBacklogTenant) (nonPersistentTopicsAnalyzeSubscriptionBacklogNamespace) (nonPersistentTopicsAnalyzeSubscriptionBacklogTopic) (nonPersistentTopicsAnalyzeSubscriptionBacklogSubName) (nonPersistentTopicsAnalyzeSubscriptionBacklogAuthoritative) nonPersistentTopicsAnalyzeSubscriptionBacklogPosition

-- ^ 
type NonPersistentTopicsCompactAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compaction" :> QueryParam "authoritative" Bool :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsCompactParameters = NonPersistentTopicsCompactParameters
  { nonPersistentTopicsCompactTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsCompactNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsCompactTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsCompactAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsCompact :: NonPersistentTopicsCompactParameters -> ClientM NoContent
nonPersistentTopicsCompact NonPersistentTopicsCompactParameters {..} = client (Proxy :: Proxy NonPersistentTopicsCompactAPI) (nonPersistentTopicsCompactTenant) (nonPersistentTopicsCompactNamespace) (nonPersistentTopicsCompactTopic) (nonPersistentTopicsCompactAuthoritative)

-- ^ 
type NonPersistentTopicsCompactionStatusAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compaction" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] LongRunningProcessStatus

data NonPersistentTopicsCompactionStatusParameters = NonPersistentTopicsCompactionStatusParameters
  { nonPersistentTopicsCompactionStatusTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsCompactionStatusNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsCompactionStatusTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsCompactionStatusAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsCompactionStatus :: NonPersistentTopicsCompactionStatusParameters -> ClientM LongRunningProcessStatus
nonPersistentTopicsCompactionStatus NonPersistentTopicsCompactionStatusParameters {..} = client (Proxy :: Proxy NonPersistentTopicsCompactionStatusAPI) (nonPersistentTopicsCompactionStatusTenant) (nonPersistentTopicsCompactionStatusNamespace) (nonPersistentTopicsCompactionStatusTopic) (nonPersistentTopicsCompactionStatusAuthoritative)

-- ^ 
type NonPersistentTopicsCreateMissedPartitionsAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "createMissedPartitions" :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsCreateMissedPartitionsParameters = NonPersistentTopicsCreateMissedPartitionsParameters
  { nonPersistentTopicsCreateMissedPartitionsTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsCreateMissedPartitionsNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsCreateMissedPartitionsTopic :: Text -- ^ Specify topic name
  } deriving (Show, Eq, Generic)

nonPersistentTopicsCreateMissedPartitions :: NonPersistentTopicsCreateMissedPartitionsParameters -> ClientM NoContent
nonPersistentTopicsCreateMissedPartitions NonPersistentTopicsCreateMissedPartitionsParameters {..} = client (Proxy :: Proxy NonPersistentTopicsCreateMissedPartitionsAPI) (nonPersistentTopicsCreateMissedPartitionsTenant) (nonPersistentTopicsCreateMissedPartitionsNamespace) (nonPersistentTopicsCreateMissedPartitionsTopic)

-- ^ This is the only REST endpoint from which non-partitioned topics could be created.
type NonPersistentTopicsCreateNonPartitionedTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> QueryParam "authoritative" Bool :> ReqBody '[JSON] (Map.Map String Text) :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsCreateNonPartitionedTopicParameters = NonPersistentTopicsCreateNonPartitionedTopicParameters
  { nonPersistentTopicsCreateNonPartitionedTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsCreateNonPartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsCreateNonPartitionedTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsCreateNonPartitionedTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsCreateNonPartitionedTopicBody :: (Map.Map String Text) -- ^ Key value pair properties for the topic metadata
  } deriving (Show, Eq, Generic)

nonPersistentTopicsCreateNonPartitionedTopic :: NonPersistentTopicsCreateNonPartitionedTopicParameters -> ClientM NoContent
nonPersistentTopicsCreateNonPartitionedTopic NonPersistentTopicsCreateNonPartitionedTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsCreateNonPartitionedTopicAPI) (nonPersistentTopicsCreateNonPartitionedTopicTenant) (nonPersistentTopicsCreateNonPartitionedTopicNamespace) (nonPersistentTopicsCreateNonPartitionedTopicTopic) (nonPersistentTopicsCreateNonPartitionedTopicAuthoritative) nonPersistentTopicsCreateNonPartitionedTopicBody

-- ^ It needs to be called before creating a producer on a partitioned topic.
type NonPersistentTopicsCreatePartitionedTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitions" :> QueryParam "createLocalTopicOnly" Bool :> ReqBody '[JSON] Int :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsCreatePartitionedTopicParameters = NonPersistentTopicsCreatePartitionedTopicParameters
  { nonPersistentTopicsCreatePartitionedTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsCreatePartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsCreatePartitionedTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsCreatePartitionedTopicBody :: Int -- ^ The number of partitions for the topic
  , nonPersistentTopicsCreatePartitionedTopicCreateLocalTopicOnly :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsCreatePartitionedTopic :: NonPersistentTopicsCreatePartitionedTopicParameters -> ClientM NoContent
nonPersistentTopicsCreatePartitionedTopic NonPersistentTopicsCreatePartitionedTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsCreatePartitionedTopicAPI) (nonPersistentTopicsCreatePartitionedTopicTenant) (nonPersistentTopicsCreatePartitionedTopicNamespace) (nonPersistentTopicsCreatePartitionedTopicTopic) (nonPersistentTopicsCreatePartitionedTopicCreateLocalTopicOnly) nonPersistentTopicsCreatePartitionedTopicBody

-- ^ Creates a subscription on the topic at the specified message id
type NonPersistentTopicsCreateSubscriptionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subscriptionName" Text :> QueryParam "authoritative" Bool :> QueryParam "replicated" Bool :> ReqBody '[JSON] ResetCursorData :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsCreateSubscriptionParameters = NonPersistentTopicsCreateSubscriptionParameters
  { nonPersistentTopicsCreateSubscriptionTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsCreateSubscriptionNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsCreateSubscriptionTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsCreateSubscriptionSubscriptionName :: Text -- ^ Name of subscription to be created
  , nonPersistentTopicsCreateSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsCreateSubscriptionReplicated :: Maybe Bool -- ^ Is replicated required to perform this operation
  , nonPersistentTopicsCreateSubscriptionMessageId :: ResetCursorData -- ^ messageId where to create the subscription. It can be 'latest', 'earliest' or (ledgerId:entryId)
  } deriving (Show, Eq, Generic)

nonPersistentTopicsCreateSubscription :: NonPersistentTopicsCreateSubscriptionParameters -> ClientM NoContent
nonPersistentTopicsCreateSubscription NonPersistentTopicsCreateSubscriptionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsCreateSubscriptionAPI) (nonPersistentTopicsCreateSubscriptionTenant) (nonPersistentTopicsCreateSubscriptionNamespace) (nonPersistentTopicsCreateSubscriptionTopic) (nonPersistentTopicsCreateSubscriptionSubscriptionName) (nonPersistentTopicsCreateSubscriptionAuthoritative) (nonPersistentTopicsCreateSubscriptionReplicated) nonPersistentTopicsCreateSubscriptionMessageId

-- ^ 
type NonPersistentTopicsDeleteDeduplicationSnapshotIntervalAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationSnapshotInterval" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeleteDeduplicationSnapshotIntervalParameters = NonPersistentTopicsDeleteDeduplicationSnapshotIntervalParameters
  { nonPersistentTopicsDeleteDeduplicationSnapshotIntervalTenant :: Text -- ^ 
  , nonPersistentTopicsDeleteDeduplicationSnapshotIntervalNamespace :: Text -- ^ 
  , nonPersistentTopicsDeleteDeduplicationSnapshotIntervalTopic :: Text -- ^ 
  , nonPersistentTopicsDeleteDeduplicationSnapshotIntervalIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsDeleteDeduplicationSnapshotIntervalAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeleteDeduplicationSnapshotInterval :: NonPersistentTopicsDeleteDeduplicationSnapshotIntervalParameters -> ClientM NoContent
nonPersistentTopicsDeleteDeduplicationSnapshotInterval NonPersistentTopicsDeleteDeduplicationSnapshotIntervalParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeleteDeduplicationSnapshotIntervalAPI) (nonPersistentTopicsDeleteDeduplicationSnapshotIntervalTenant) (nonPersistentTopicsDeleteDeduplicationSnapshotIntervalNamespace) (nonPersistentTopicsDeleteDeduplicationSnapshotIntervalTopic) (nonPersistentTopicsDeleteDeduplicationSnapshotIntervalIsGlobal) (nonPersistentTopicsDeleteDeduplicationSnapshotIntervalAuthoritative)

-- ^ 
type NonPersistentTopicsDeleteDelayedDeliveryPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "delayedDelivery" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeleteDelayedDeliveryPoliciesParameters = NonPersistentTopicsDeleteDelayedDeliveryPoliciesParameters
  { nonPersistentTopicsDeleteDelayedDeliveryPoliciesTenant :: Text -- ^ 
  , nonPersistentTopicsDeleteDelayedDeliveryPoliciesNamespace :: Text -- ^ 
  , nonPersistentTopicsDeleteDelayedDeliveryPoliciesTopic :: Text -- ^ 
  , nonPersistentTopicsDeleteDelayedDeliveryPoliciesIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsDeleteDelayedDeliveryPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeleteDelayedDeliveryPolicies :: NonPersistentTopicsDeleteDelayedDeliveryPoliciesParameters -> ClientM NoContent
nonPersistentTopicsDeleteDelayedDeliveryPolicies NonPersistentTopicsDeleteDelayedDeliveryPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeleteDelayedDeliveryPoliciesAPI) (nonPersistentTopicsDeleteDelayedDeliveryPoliciesTenant) (nonPersistentTopicsDeleteDelayedDeliveryPoliciesNamespace) (nonPersistentTopicsDeleteDelayedDeliveryPoliciesTopic) (nonPersistentTopicsDeleteDelayedDeliveryPoliciesIsGlobal) (nonPersistentTopicsDeleteDelayedDeliveryPoliciesAuthoritative)

-- ^ 
type NonPersistentTopicsDeleteInactiveTopicPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "inactiveTopicPolicies" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeleteInactiveTopicPoliciesParameters = NonPersistentTopicsDeleteInactiveTopicPoliciesParameters
  { nonPersistentTopicsDeleteInactiveTopicPoliciesTenant :: Text -- ^ 
  , nonPersistentTopicsDeleteInactiveTopicPoliciesNamespace :: Text -- ^ 
  , nonPersistentTopicsDeleteInactiveTopicPoliciesTopic :: Text -- ^ 
  , nonPersistentTopicsDeleteInactiveTopicPoliciesIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsDeleteInactiveTopicPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeleteInactiveTopicPolicies :: NonPersistentTopicsDeleteInactiveTopicPoliciesParameters -> ClientM NoContent
nonPersistentTopicsDeleteInactiveTopicPolicies NonPersistentTopicsDeleteInactiveTopicPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeleteInactiveTopicPoliciesAPI) (nonPersistentTopicsDeleteInactiveTopicPoliciesTenant) (nonPersistentTopicsDeleteInactiveTopicPoliciesNamespace) (nonPersistentTopicsDeleteInactiveTopicPoliciesTopic) (nonPersistentTopicsDeleteInactiveTopicPoliciesIsGlobal) (nonPersistentTopicsDeleteInactiveTopicPoliciesAuthoritative)

-- ^ 
type NonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnConsumer" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters = NonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters
  { nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerTenant :: Text -- ^ 
  , nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerNamespace :: Text -- ^ 
  , nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerTopic :: Text -- ^ 
  , nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumer :: NonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters -> ClientM NoContent
nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumer NonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerAPI) (nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerTenant) (nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerNamespace) (nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerTopic) (nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerIsGlobal) (nonPersistentTopicsDeleteMaxUnackedMessagesOnConsumerAuthoritative)

-- ^ 
type NonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters = NonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters
  { nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionTenant :: Text -- ^ 
  , nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionNamespace :: Text -- ^ 
  , nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionTopic :: Text -- ^ 
  , nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscription :: NonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters -> ClientM NoContent
nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscription NonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionAPI) (nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionTenant) (nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionNamespace) (nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionTopic) (nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionIsGlobal) (nonPersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionAuthoritative)

-- ^ It will also delete all the partitions of the topic if it exists.
type NonPersistentTopicsDeletePartitionedTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitions" :> QueryParam "force" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeletePartitionedTopicParameters = NonPersistentTopicsDeletePartitionedTopicParameters
  { nonPersistentTopicsDeletePartitionedTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsDeletePartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsDeletePartitionedTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsDeletePartitionedTopicForce :: Maybe Bool -- ^ Stop all producer/consumer/replicator and delete topic forcefully
  , nonPersistentTopicsDeletePartitionedTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeletePartitionedTopic :: NonPersistentTopicsDeletePartitionedTopicParameters -> ClientM NoContent
nonPersistentTopicsDeletePartitionedTopic NonPersistentTopicsDeletePartitionedTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeletePartitionedTopicAPI) (nonPersistentTopicsDeletePartitionedTopicTenant) (nonPersistentTopicsDeletePartitionedTopicNamespace) (nonPersistentTopicsDeletePartitionedTopicTopic) (nonPersistentTopicsDeletePartitionedTopicForce) (nonPersistentTopicsDeletePartitionedTopicAuthoritative)

-- ^ 
type NonPersistentTopicsDeleteShadowTopicsAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "shadowTopics" :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeleteShadowTopicsParameters = NonPersistentTopicsDeleteShadowTopicsParameters
  { nonPersistentTopicsDeleteShadowTopicsTenant :: Text -- ^ 
  , nonPersistentTopicsDeleteShadowTopicsNamespace :: Text -- ^ 
  , nonPersistentTopicsDeleteShadowTopicsTopic :: Text -- ^ 
  , nonPersistentTopicsDeleteShadowTopicsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeleteShadowTopics :: NonPersistentTopicsDeleteShadowTopicsParameters -> ClientM NoContent
nonPersistentTopicsDeleteShadowTopics NonPersistentTopicsDeleteShadowTopicsParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeleteShadowTopicsAPI) (nonPersistentTopicsDeleteShadowTopicsTenant) (nonPersistentTopicsDeleteShadowTopicsNamespace) (nonPersistentTopicsDeleteShadowTopicsTopic) (nonPersistentTopicsDeleteShadowTopicsAuthoritative)

-- ^ The subscription cannot be deleted if delete is not forcefully and there are any active consumers attached to it. Force delete ignores connected consumers and deletes subscription by explicitly closing them.
type NonPersistentTopicsDeleteSubscriptionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> QueryParam "force" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeleteSubscriptionParameters = NonPersistentTopicsDeleteSubscriptionParameters
  { nonPersistentTopicsDeleteSubscriptionTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsDeleteSubscriptionNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsDeleteSubscriptionTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsDeleteSubscriptionSubName :: Text -- ^ Subscription to be deleted
  , nonPersistentTopicsDeleteSubscriptionForce :: Maybe Bool -- ^ Disconnect and close all consumers and delete subscription forcefully
  , nonPersistentTopicsDeleteSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeleteSubscription :: NonPersistentTopicsDeleteSubscriptionParameters -> ClientM NoContent
nonPersistentTopicsDeleteSubscription NonPersistentTopicsDeleteSubscriptionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeleteSubscriptionAPI) (nonPersistentTopicsDeleteSubscriptionTenant) (nonPersistentTopicsDeleteSubscriptionNamespace) (nonPersistentTopicsDeleteSubscriptionTopic) (nonPersistentTopicsDeleteSubscriptionSubName) (nonPersistentTopicsDeleteSubscriptionForce) (nonPersistentTopicsDeleteSubscriptionAuthoritative)

-- ^ The topic cannot be deleted if delete is not forcefully and there's any active subscription or producer connected to the it. Force delete ignores connected clients and deletes topic by explicitly closing them.
type NonPersistentTopicsDeleteTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> QueryParam "force" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeleteTopicParameters = NonPersistentTopicsDeleteTopicParameters
  { nonPersistentTopicsDeleteTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsDeleteTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsDeleteTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsDeleteTopicForce :: Maybe Bool -- ^ Stop all producer/consumer/replicator and delete topic forcefully
  , nonPersistentTopicsDeleteTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeleteTopic :: NonPersistentTopicsDeleteTopicParameters -> ClientM NoContent
nonPersistentTopicsDeleteTopic NonPersistentTopicsDeleteTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeleteTopicAPI) (nonPersistentTopicsDeleteTopicTenant) (nonPersistentTopicsDeleteTopicNamespace) (nonPersistentTopicsDeleteTopicTopic) (nonPersistentTopicsDeleteTopicForce) (nonPersistentTopicsDeleteTopicAuthoritative)

-- ^ 
type NonPersistentTopicsDeleteTopicPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "policies" :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsDeleteTopicPoliciesParameters = NonPersistentTopicsDeleteTopicPoliciesParameters
  { nonPersistentTopicsDeleteTopicPoliciesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsDeleteTopicPoliciesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsDeleteTopicPoliciesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsDeleteTopicPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsDeleteTopicPolicies :: NonPersistentTopicsDeleteTopicPoliciesParameters -> ClientM NoContent
nonPersistentTopicsDeleteTopicPolicies NonPersistentTopicsDeleteTopicPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsDeleteTopicPoliciesAPI) (nonPersistentTopicsDeleteTopicPoliciesTenant) (nonPersistentTopicsDeleteTopicPoliciesNamespace) (nonPersistentTopicsDeleteTopicPoliciesTopic) (nonPersistentTopicsDeleteTopicPoliciesAuthoritative)

-- ^ 
type NonPersistentTopicsExamineMessageAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "examinemessage" :> QueryParam "initialPosition" Text :> QueryParam "messagePosition" Integer :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] NoContent

data NonPersistentTopicsExamineMessageParameters = NonPersistentTopicsExamineMessageParameters
  { nonPersistentTopicsExamineMessageTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsExamineMessageNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsExamineMessageTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsExamineMessageInitialPosition :: Maybe Text -- ^ Relative start position to examine message.It can be 'latest' or 'earliest'
  , nonPersistentTopicsExamineMessageMessagePosition :: Maybe Integer -- ^ The position of messages (default 1)
  , nonPersistentTopicsExamineMessageAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsExamineMessage :: NonPersistentTopicsExamineMessageParameters -> ClientM NoContent
nonPersistentTopicsExamineMessage NonPersistentTopicsExamineMessageParameters {..} = client (Proxy :: Proxy NonPersistentTopicsExamineMessageAPI) (nonPersistentTopicsExamineMessageTenant) (nonPersistentTopicsExamineMessageNamespace) (nonPersistentTopicsExamineMessageTopic) (nonPersistentTopicsExamineMessageInitialPosition) (nonPersistentTopicsExamineMessageMessagePosition) (nonPersistentTopicsExamineMessageAuthoritative)

-- ^ 
type NonPersistentTopicsExpireMessagesForAllSubscriptionsAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "all_subscription" :> "expireMessages" :> Capture "expireTimeInSeconds" Int :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsExpireMessagesForAllSubscriptionsParameters = NonPersistentTopicsExpireMessagesForAllSubscriptionsParameters
  { nonPersistentTopicsExpireMessagesForAllSubscriptionsTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsExpireMessagesForAllSubscriptionsNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsExpireMessagesForAllSubscriptionsTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsExpireMessagesForAllSubscriptionsExpireTimeInSeconds :: Int -- ^ Expires beyond the specified number of seconds
  , nonPersistentTopicsExpireMessagesForAllSubscriptionsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsExpireMessagesForAllSubscriptions :: NonPersistentTopicsExpireMessagesForAllSubscriptionsParameters -> ClientM NoContent
nonPersistentTopicsExpireMessagesForAllSubscriptions NonPersistentTopicsExpireMessagesForAllSubscriptionsParameters {..} = client (Proxy :: Proxy NonPersistentTopicsExpireMessagesForAllSubscriptionsAPI) (nonPersistentTopicsExpireMessagesForAllSubscriptionsTenant) (nonPersistentTopicsExpireMessagesForAllSubscriptionsNamespace) (nonPersistentTopicsExpireMessagesForAllSubscriptionsTopic) (nonPersistentTopicsExpireMessagesForAllSubscriptionsExpireTimeInSeconds) (nonPersistentTopicsExpireMessagesForAllSubscriptionsAuthoritative)

-- ^ 
type NonPersistentTopicsGetAutoSubscriptionCreationAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "autoSubscriptionCreation" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] AutoSubscriptionCreationOverrideImpl

data NonPersistentTopicsGetAutoSubscriptionCreationParameters = NonPersistentTopicsGetAutoSubscriptionCreationParameters
  { nonPersistentTopicsGetAutoSubscriptionCreationTenant :: Text -- ^ 
  , nonPersistentTopicsGetAutoSubscriptionCreationNamespace :: Text -- ^ 
  , nonPersistentTopicsGetAutoSubscriptionCreationTopic :: Text -- ^ 
  , nonPersistentTopicsGetAutoSubscriptionCreationApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetAutoSubscriptionCreationIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetAutoSubscriptionCreationAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetAutoSubscriptionCreation :: NonPersistentTopicsGetAutoSubscriptionCreationParameters -> ClientM AutoSubscriptionCreationOverrideImpl
nonPersistentTopicsGetAutoSubscriptionCreation NonPersistentTopicsGetAutoSubscriptionCreationParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetAutoSubscriptionCreationAPI) (nonPersistentTopicsGetAutoSubscriptionCreationTenant) (nonPersistentTopicsGetAutoSubscriptionCreationNamespace) (nonPersistentTopicsGetAutoSubscriptionCreationTopic) (nonPersistentTopicsGetAutoSubscriptionCreationApplied) (nonPersistentTopicsGetAutoSubscriptionCreationIsGlobal) (nonPersistentTopicsGetAutoSubscriptionCreationAuthoritative)

-- ^ 
type NonPersistentTopicsGetBacklogAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlog" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PersistentOfflineTopicStats

data NonPersistentTopicsGetBacklogParameters = NonPersistentTopicsGetBacklogParameters
  { nonPersistentTopicsGetBacklogTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetBacklogNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetBacklogTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetBacklogAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetBacklog :: NonPersistentTopicsGetBacklogParameters -> ClientM PersistentOfflineTopicStats
nonPersistentTopicsGetBacklog NonPersistentTopicsGetBacklogParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetBacklogAPI) (nonPersistentTopicsGetBacklogTenant) (nonPersistentTopicsGetBacklogNamespace) (nonPersistentTopicsGetBacklogTopic) (nonPersistentTopicsGetBacklogAuthoritative)

-- ^ 
type NonPersistentTopicsGetBacklogQuotaMapAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlogQuotaMap" :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> Verb 'GET 200 '[JSON] ((Map.Map String BacklogQuota))

data NonPersistentTopicsGetBacklogQuotaMapParameters = NonPersistentTopicsGetBacklogQuotaMapParameters
  { nonPersistentTopicsGetBacklogQuotaMapTenant :: Text -- ^ 
  , nonPersistentTopicsGetBacklogQuotaMapNamespace :: Text -- ^ 
  , nonPersistentTopicsGetBacklogQuotaMapTopic :: Text -- ^ 
  , nonPersistentTopicsGetBacklogQuotaMapApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetBacklogQuotaMapAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsGetBacklogQuotaMapIsGlobal :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetBacklogQuotaMap :: NonPersistentTopicsGetBacklogQuotaMapParameters -> ClientM (Map.Map String BacklogQuota)
nonPersistentTopicsGetBacklogQuotaMap NonPersistentTopicsGetBacklogQuotaMapParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetBacklogQuotaMapAPI) (nonPersistentTopicsGetBacklogQuotaMapTenant) (nonPersistentTopicsGetBacklogQuotaMapNamespace) (nonPersistentTopicsGetBacklogQuotaMapTopic) (nonPersistentTopicsGetBacklogQuotaMapApplied) (nonPersistentTopicsGetBacklogQuotaMapAuthoritative) (nonPersistentTopicsGetBacklogQuotaMapIsGlobal)

-- ^ 
type NonPersistentTopicsGetBacklogSizeByMessageIdAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlogSize" :> QueryParam "authoritative" Bool :> Verb 'PUT 200 '[JSON] Integer

data NonPersistentTopicsGetBacklogSizeByMessageIdParameters = NonPersistentTopicsGetBacklogSizeByMessageIdParameters
  { nonPersistentTopicsGetBacklogSizeByMessageIdTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetBacklogSizeByMessageIdNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetBacklogSizeByMessageIdTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetBacklogSizeByMessageIdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetBacklogSizeByMessageId :: NonPersistentTopicsGetBacklogSizeByMessageIdParameters -> ClientM Integer
nonPersistentTopicsGetBacklogSizeByMessageId NonPersistentTopicsGetBacklogSizeByMessageIdParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetBacklogSizeByMessageIdAPI) (nonPersistentTopicsGetBacklogSizeByMessageIdTenant) (nonPersistentTopicsGetBacklogSizeByMessageIdNamespace) (nonPersistentTopicsGetBacklogSizeByMessageIdTopic) (nonPersistentTopicsGetBacklogSizeByMessageIdAuthoritative)

-- ^ 
type NonPersistentTopicsGetCompactionThresholdAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compactionThreshold" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Integer

data NonPersistentTopicsGetCompactionThresholdParameters = NonPersistentTopicsGetCompactionThresholdParameters
  { nonPersistentTopicsGetCompactionThresholdTenant :: Text -- ^ 
  , nonPersistentTopicsGetCompactionThresholdNamespace :: Text -- ^ 
  , nonPersistentTopicsGetCompactionThresholdTopic :: Text -- ^ 
  , nonPersistentTopicsGetCompactionThresholdApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetCompactionThresholdIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetCompactionThresholdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetCompactionThreshold :: NonPersistentTopicsGetCompactionThresholdParameters -> ClientM Integer
nonPersistentTopicsGetCompactionThreshold NonPersistentTopicsGetCompactionThresholdParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetCompactionThresholdAPI) (nonPersistentTopicsGetCompactionThresholdTenant) (nonPersistentTopicsGetCompactionThresholdNamespace) (nonPersistentTopicsGetCompactionThresholdTopic) (nonPersistentTopicsGetCompactionThresholdApplied) (nonPersistentTopicsGetCompactionThresholdIsGlobal) (nonPersistentTopicsGetCompactionThresholdAuthoritative)

-- ^ 
type NonPersistentTopicsGetDeduplicationAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationEnabled" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Bool

data NonPersistentTopicsGetDeduplicationParameters = NonPersistentTopicsGetDeduplicationParameters
  { nonPersistentTopicsGetDeduplicationTenant :: Text -- ^ 
  , nonPersistentTopicsGetDeduplicationNamespace :: Text -- ^ 
  , nonPersistentTopicsGetDeduplicationTopic :: Text -- ^ 
  , nonPersistentTopicsGetDeduplicationApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetDeduplicationIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetDeduplicationAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetDeduplication :: NonPersistentTopicsGetDeduplicationParameters -> ClientM Bool
nonPersistentTopicsGetDeduplication NonPersistentTopicsGetDeduplicationParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetDeduplicationAPI) (nonPersistentTopicsGetDeduplicationTenant) (nonPersistentTopicsGetDeduplicationNamespace) (nonPersistentTopicsGetDeduplicationTopic) (nonPersistentTopicsGetDeduplicationApplied) (nonPersistentTopicsGetDeduplicationIsGlobal) (nonPersistentTopicsGetDeduplicationAuthoritative)

-- ^ 
type NonPersistentTopicsGetDeduplicationSnapshotIntervalAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationSnapshotInterval" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetDeduplicationSnapshotIntervalParameters = NonPersistentTopicsGetDeduplicationSnapshotIntervalParameters
  { nonPersistentTopicsGetDeduplicationSnapshotIntervalTenant :: Text -- ^ 
  , nonPersistentTopicsGetDeduplicationSnapshotIntervalNamespace :: Text -- ^ 
  , nonPersistentTopicsGetDeduplicationSnapshotIntervalTopic :: Text -- ^ 
  , nonPersistentTopicsGetDeduplicationSnapshotIntervalIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetDeduplicationSnapshotIntervalAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetDeduplicationSnapshotInterval :: NonPersistentTopicsGetDeduplicationSnapshotIntervalParameters -> ClientM Int
nonPersistentTopicsGetDeduplicationSnapshotInterval NonPersistentTopicsGetDeduplicationSnapshotIntervalParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetDeduplicationSnapshotIntervalAPI) (nonPersistentTopicsGetDeduplicationSnapshotIntervalTenant) (nonPersistentTopicsGetDeduplicationSnapshotIntervalNamespace) (nonPersistentTopicsGetDeduplicationSnapshotIntervalTopic) (nonPersistentTopicsGetDeduplicationSnapshotIntervalIsGlobal) (nonPersistentTopicsGetDeduplicationSnapshotIntervalAuthoritative)

-- ^ 
type NonPersistentTopicsGetDelayedDeliveryPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "delayedDelivery" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DelayedDeliveryPolicies

data NonPersistentTopicsGetDelayedDeliveryPoliciesParameters = NonPersistentTopicsGetDelayedDeliveryPoliciesParameters
  { nonPersistentTopicsGetDelayedDeliveryPoliciesTenant :: Text -- ^ 
  , nonPersistentTopicsGetDelayedDeliveryPoliciesNamespace :: Text -- ^ 
  , nonPersistentTopicsGetDelayedDeliveryPoliciesTopic :: Text -- ^ 
  , nonPersistentTopicsGetDelayedDeliveryPoliciesIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetDelayedDeliveryPoliciesApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetDelayedDeliveryPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetDelayedDeliveryPolicies :: NonPersistentTopicsGetDelayedDeliveryPoliciesParameters -> ClientM DelayedDeliveryPolicies
nonPersistentTopicsGetDelayedDeliveryPolicies NonPersistentTopicsGetDelayedDeliveryPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetDelayedDeliveryPoliciesAPI) (nonPersistentTopicsGetDelayedDeliveryPoliciesTenant) (nonPersistentTopicsGetDelayedDeliveryPoliciesNamespace) (nonPersistentTopicsGetDelayedDeliveryPoliciesTopic) (nonPersistentTopicsGetDelayedDeliveryPoliciesIsGlobal) (nonPersistentTopicsGetDelayedDeliveryPoliciesApplied) (nonPersistentTopicsGetDelayedDeliveryPoliciesAuthoritative)

-- ^ 
type NonPersistentTopicsGetDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatchRate" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DispatchRateImpl

data NonPersistentTopicsGetDispatchRateParameters = NonPersistentTopicsGetDispatchRateParameters
  { nonPersistentTopicsGetDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsGetDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsGetDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsGetDispatchRateApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetDispatchRate :: NonPersistentTopicsGetDispatchRateParameters -> ClientM DispatchRateImpl
nonPersistentTopicsGetDispatchRate NonPersistentTopicsGetDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetDispatchRateAPI) (nonPersistentTopicsGetDispatchRateTenant) (nonPersistentTopicsGetDispatchRateNamespace) (nonPersistentTopicsGetDispatchRateTopic) (nonPersistentTopicsGetDispatchRateApplied) (nonPersistentTopicsGetDispatchRateIsGlobal) (nonPersistentTopicsGetDispatchRateAuthoritative)

-- ^ 
type NonPersistentTopicsGetDispatcherPauseOnAckStatePersistentAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatcherPauseOnAckStatePersistent" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters = NonPersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters
  { nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentTenant :: Text -- ^ 
  , nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentNamespace :: Text -- ^ 
  , nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentTopic :: Text -- ^ 
  , nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetDispatcherPauseOnAckStatePersistent :: NonPersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters -> ClientM Int
nonPersistentTopicsGetDispatcherPauseOnAckStatePersistent NonPersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetDispatcherPauseOnAckStatePersistentAPI) (nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentTenant) (nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentNamespace) (nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentTopic) (nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentApplied) (nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentIsGlobal) (nonPersistentTopicsGetDispatcherPauseOnAckStatePersistentAuthoritative)

-- ^ 
type NonPersistentTopicsGetEntryFiltersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "entryFilters" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] EntryFilters

data NonPersistentTopicsGetEntryFiltersParameters = NonPersistentTopicsGetEntryFiltersParameters
  { nonPersistentTopicsGetEntryFiltersTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetEntryFiltersNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetEntryFiltersTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetEntryFiltersApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetEntryFiltersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetEntryFiltersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetEntryFilters :: NonPersistentTopicsGetEntryFiltersParameters -> ClientM EntryFilters
nonPersistentTopicsGetEntryFilters NonPersistentTopicsGetEntryFiltersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetEntryFiltersAPI) (nonPersistentTopicsGetEntryFiltersTenant) (nonPersistentTopicsGetEntryFiltersNamespace) (nonPersistentTopicsGetEntryFiltersTopic) (nonPersistentTopicsGetEntryFiltersApplied) (nonPersistentTopicsGetEntryFiltersIsGlobal) (nonPersistentTopicsGetEntryFiltersAuthoritative)

-- ^ 
type NonPersistentTopicsGetExpireTopicMessagesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "expireMessages" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] ResetCursorData :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsGetExpireTopicMessagesParameters = NonPersistentTopicsGetExpireTopicMessagesParameters
  { nonPersistentTopicsGetExpireTopicMessagesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetExpireTopicMessagesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetExpireTopicMessagesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetExpireTopicMessagesSubName :: Text -- ^ Subscription to be Expiry messages on
  , nonPersistentTopicsGetExpireTopicMessagesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsGetExpireTopicMessagesMessageId :: ResetCursorData -- ^ messageId to reset back to (ledgerId:entryId)
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetExpireTopicMessages :: NonPersistentTopicsGetExpireTopicMessagesParameters -> ClientM NoContent
nonPersistentTopicsGetExpireTopicMessages NonPersistentTopicsGetExpireTopicMessagesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetExpireTopicMessagesAPI) (nonPersistentTopicsGetExpireTopicMessagesTenant) (nonPersistentTopicsGetExpireTopicMessagesNamespace) (nonPersistentTopicsGetExpireTopicMessagesTopic) (nonPersistentTopicsGetExpireTopicMessagesSubName) (nonPersistentTopicsGetExpireTopicMessagesAuthoritative) nonPersistentTopicsGetExpireTopicMessagesMessageId

-- ^ 
type NonPersistentTopicsGetInactiveTopicPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "inactiveTopicPolicies" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] InactiveTopicPolicies

data NonPersistentTopicsGetInactiveTopicPoliciesParameters = NonPersistentTopicsGetInactiveTopicPoliciesParameters
  { nonPersistentTopicsGetInactiveTopicPoliciesTenant :: Text -- ^ 
  , nonPersistentTopicsGetInactiveTopicPoliciesNamespace :: Text -- ^ 
  , nonPersistentTopicsGetInactiveTopicPoliciesTopic :: Text -- ^ 
  , nonPersistentTopicsGetInactiveTopicPoliciesApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetInactiveTopicPoliciesIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetInactiveTopicPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetInactiveTopicPolicies :: NonPersistentTopicsGetInactiveTopicPoliciesParameters -> ClientM InactiveTopicPolicies
nonPersistentTopicsGetInactiveTopicPolicies NonPersistentTopicsGetInactiveTopicPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetInactiveTopicPoliciesAPI) (nonPersistentTopicsGetInactiveTopicPoliciesTenant) (nonPersistentTopicsGetInactiveTopicPoliciesNamespace) (nonPersistentTopicsGetInactiveTopicPoliciesTopic) (nonPersistentTopicsGetInactiveTopicPoliciesApplied) (nonPersistentTopicsGetInactiveTopicPoliciesIsGlobal) (nonPersistentTopicsGetInactiveTopicPoliciesAuthoritative)

-- ^ 
type NonPersistentTopicsGetInternalStatsAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "internalStats" :> QueryParam "authoritative" Bool :> QueryParam "metadata" Bool :> Verb 'GET 200 '[JSON] PersistentTopicInternalStats

data NonPersistentTopicsGetInternalStatsParameters = NonPersistentTopicsGetInternalStatsParameters
  { nonPersistentTopicsGetInternalStatsTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetInternalStatsNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetInternalStatsTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetInternalStatsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsGetInternalStatsMetadata :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetInternalStats :: NonPersistentTopicsGetInternalStatsParameters -> ClientM PersistentTopicInternalStats
nonPersistentTopicsGetInternalStats NonPersistentTopicsGetInternalStatsParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetInternalStatsAPI) (nonPersistentTopicsGetInternalStatsTenant) (nonPersistentTopicsGetInternalStatsNamespace) (nonPersistentTopicsGetInternalStatsTopic) (nonPersistentTopicsGetInternalStatsAuthoritative) (nonPersistentTopicsGetInternalStatsMetadata)

-- ^ 
type NonPersistentTopicsGetLastMessageIdAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "lastMessageId" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] MessageIdAdv

data NonPersistentTopicsGetLastMessageIdParameters = NonPersistentTopicsGetLastMessageIdParameters
  { nonPersistentTopicsGetLastMessageIdTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetLastMessageIdNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetLastMessageIdTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetLastMessageIdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetLastMessageId :: NonPersistentTopicsGetLastMessageIdParameters -> ClientM MessageIdAdv
nonPersistentTopicsGetLastMessageId NonPersistentTopicsGetLastMessageIdParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetLastMessageIdAPI) (nonPersistentTopicsGetLastMessageIdTenant) (nonPersistentTopicsGetLastMessageIdNamespace) (nonPersistentTopicsGetLastMessageIdTopic) (nonPersistentTopicsGetLastMessageIdAuthoritative)

-- ^ 
type NonPersistentTopicsGetListAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> QueryParam "bundle" Text :> QueryParam "includeSystemTopic" Bool :> Verb 'GET 200 '[JSON] [Text]

data NonPersistentTopicsGetListParameters = NonPersistentTopicsGetListParameters
  { nonPersistentTopicsGetListTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetListNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetListBundle :: Maybe Text -- ^ Specify the bundle name
  , nonPersistentTopicsGetListIncludeSystemTopic :: Maybe Bool -- ^ Include system topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetList :: NonPersistentTopicsGetListParameters -> ClientM [Text]
nonPersistentTopicsGetList NonPersistentTopicsGetListParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetListAPI) (nonPersistentTopicsGetListTenant) (nonPersistentTopicsGetListNamespace) (nonPersistentTopicsGetListBundle) (nonPersistentTopicsGetListIncludeSystemTopic)

-- ^ 
type NonPersistentTopicsGetListFromBundleAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> Verb 'GET 200 '[JSON] [Text]

data NonPersistentTopicsGetListFromBundleParameters = NonPersistentTopicsGetListFromBundleParameters
  { nonPersistentTopicsGetListFromBundleTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetListFromBundleNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetListFromBundleBundle :: Text -- ^ Bundle range of a topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetListFromBundle :: NonPersistentTopicsGetListFromBundleParameters -> ClientM [Text]
nonPersistentTopicsGetListFromBundle NonPersistentTopicsGetListFromBundleParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetListFromBundleAPI) (nonPersistentTopicsGetListFromBundleTenant) (nonPersistentTopicsGetListFromBundleNamespace) (nonPersistentTopicsGetListFromBundleBundle)

-- ^ 
type NonPersistentTopicsGetManagedLedgerInfoAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "internal-info" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PartitionedManagedLedgerInfo

data NonPersistentTopicsGetManagedLedgerInfoParameters = NonPersistentTopicsGetManagedLedgerInfoParameters
  { nonPersistentTopicsGetManagedLedgerInfoTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetManagedLedgerInfoNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetManagedLedgerInfoTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetManagedLedgerInfoAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetManagedLedgerInfo :: NonPersistentTopicsGetManagedLedgerInfoParameters -> ClientM PartitionedManagedLedgerInfo
nonPersistentTopicsGetManagedLedgerInfo NonPersistentTopicsGetManagedLedgerInfoParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetManagedLedgerInfoAPI) (nonPersistentTopicsGetManagedLedgerInfoTenant) (nonPersistentTopicsGetManagedLedgerInfoNamespace) (nonPersistentTopicsGetManagedLedgerInfoTopic) (nonPersistentTopicsGetManagedLedgerInfoAuthoritative)

-- ^ 
type NonPersistentTopicsGetMaxConsumersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumers" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetMaxConsumersParameters = NonPersistentTopicsGetMaxConsumersParameters
  { nonPersistentTopicsGetMaxConsumersTenant :: Text -- ^ 
  , nonPersistentTopicsGetMaxConsumersNamespace :: Text -- ^ 
  , nonPersistentTopicsGetMaxConsumersTopic :: Text -- ^ 
  , nonPersistentTopicsGetMaxConsumersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxConsumersApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxConsumersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMaxConsumers :: NonPersistentTopicsGetMaxConsumersParameters -> ClientM Int
nonPersistentTopicsGetMaxConsumers NonPersistentTopicsGetMaxConsumersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMaxConsumersAPI) (nonPersistentTopicsGetMaxConsumersTenant) (nonPersistentTopicsGetMaxConsumersNamespace) (nonPersistentTopicsGetMaxConsumersTopic) (nonPersistentTopicsGetMaxConsumersIsGlobal) (nonPersistentTopicsGetMaxConsumersApplied) (nonPersistentTopicsGetMaxConsumersAuthoritative)

-- ^ 
type NonPersistentTopicsGetMaxConsumersPerSubscriptionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumersPerSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetMaxConsumersPerSubscriptionParameters = NonPersistentTopicsGetMaxConsumersPerSubscriptionParameters
  { nonPersistentTopicsGetMaxConsumersPerSubscriptionTenant :: Text -- ^ 
  , nonPersistentTopicsGetMaxConsumersPerSubscriptionNamespace :: Text -- ^ 
  , nonPersistentTopicsGetMaxConsumersPerSubscriptionTopic :: Text -- ^ 
  , nonPersistentTopicsGetMaxConsumersPerSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxConsumersPerSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMaxConsumersPerSubscription :: NonPersistentTopicsGetMaxConsumersPerSubscriptionParameters -> ClientM Int
nonPersistentTopicsGetMaxConsumersPerSubscription NonPersistentTopicsGetMaxConsumersPerSubscriptionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMaxConsumersPerSubscriptionAPI) (nonPersistentTopicsGetMaxConsumersPerSubscriptionTenant) (nonPersistentTopicsGetMaxConsumersPerSubscriptionNamespace) (nonPersistentTopicsGetMaxConsumersPerSubscriptionTopic) (nonPersistentTopicsGetMaxConsumersPerSubscriptionIsGlobal) (nonPersistentTopicsGetMaxConsumersPerSubscriptionAuthoritative)

-- ^ 
type NonPersistentTopicsGetMaxMessageSizeAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxMessageSize" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetMaxMessageSizeParameters = NonPersistentTopicsGetMaxMessageSizeParameters
  { nonPersistentTopicsGetMaxMessageSizeTenant :: Text -- ^ 
  , nonPersistentTopicsGetMaxMessageSizeNamespace :: Text -- ^ 
  , nonPersistentTopicsGetMaxMessageSizeTopic :: Text -- ^ 
  , nonPersistentTopicsGetMaxMessageSizeIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxMessageSizeAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMaxMessageSize :: NonPersistentTopicsGetMaxMessageSizeParameters -> ClientM Int
nonPersistentTopicsGetMaxMessageSize NonPersistentTopicsGetMaxMessageSizeParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMaxMessageSizeAPI) (nonPersistentTopicsGetMaxMessageSizeTenant) (nonPersistentTopicsGetMaxMessageSizeNamespace) (nonPersistentTopicsGetMaxMessageSizeTopic) (nonPersistentTopicsGetMaxMessageSizeIsGlobal) (nonPersistentTopicsGetMaxMessageSizeAuthoritative)

-- ^ 
type NonPersistentTopicsGetMaxProducersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxProducers" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetMaxProducersParameters = NonPersistentTopicsGetMaxProducersParameters
  { nonPersistentTopicsGetMaxProducersTenant :: Text -- ^ 
  , nonPersistentTopicsGetMaxProducersNamespace :: Text -- ^ 
  , nonPersistentTopicsGetMaxProducersTopic :: Text -- ^ 
  , nonPersistentTopicsGetMaxProducersApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxProducersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxProducersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMaxProducers :: NonPersistentTopicsGetMaxProducersParameters -> ClientM Int
nonPersistentTopicsGetMaxProducers NonPersistentTopicsGetMaxProducersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMaxProducersAPI) (nonPersistentTopicsGetMaxProducersTenant) (nonPersistentTopicsGetMaxProducersNamespace) (nonPersistentTopicsGetMaxProducersTopic) (nonPersistentTopicsGetMaxProducersApplied) (nonPersistentTopicsGetMaxProducersIsGlobal) (nonPersistentTopicsGetMaxProducersAuthoritative)

-- ^ 
type NonPersistentTopicsGetMaxSubscriptionsPerTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxSubscriptionsPerTopic" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetMaxSubscriptionsPerTopicParameters = NonPersistentTopicsGetMaxSubscriptionsPerTopicParameters
  { nonPersistentTopicsGetMaxSubscriptionsPerTopicTenant :: Text -- ^ 
  , nonPersistentTopicsGetMaxSubscriptionsPerTopicNamespace :: Text -- ^ 
  , nonPersistentTopicsGetMaxSubscriptionsPerTopicTopic :: Text -- ^ 
  , nonPersistentTopicsGetMaxSubscriptionsPerTopicIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxSubscriptionsPerTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMaxSubscriptionsPerTopic :: NonPersistentTopicsGetMaxSubscriptionsPerTopicParameters -> ClientM Int
nonPersistentTopicsGetMaxSubscriptionsPerTopic NonPersistentTopicsGetMaxSubscriptionsPerTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMaxSubscriptionsPerTopicAPI) (nonPersistentTopicsGetMaxSubscriptionsPerTopicTenant) (nonPersistentTopicsGetMaxSubscriptionsPerTopicNamespace) (nonPersistentTopicsGetMaxSubscriptionsPerTopicTopic) (nonPersistentTopicsGetMaxSubscriptionsPerTopicIsGlobal) (nonPersistentTopicsGetMaxSubscriptionsPerTopicAuthoritative)

-- ^ 
type NonPersistentTopicsGetMaxUnackedMessagesOnConsumerAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnConsumer" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetMaxUnackedMessagesOnConsumerParameters = NonPersistentTopicsGetMaxUnackedMessagesOnConsumerParameters
  { nonPersistentTopicsGetMaxUnackedMessagesOnConsumerTenant :: Text -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnConsumerNamespace :: Text -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnConsumerTopic :: Text -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnConsumerApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnConsumerIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnConsumerAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMaxUnackedMessagesOnConsumer :: NonPersistentTopicsGetMaxUnackedMessagesOnConsumerParameters -> ClientM Int
nonPersistentTopicsGetMaxUnackedMessagesOnConsumer NonPersistentTopicsGetMaxUnackedMessagesOnConsumerParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMaxUnackedMessagesOnConsumerAPI) (nonPersistentTopicsGetMaxUnackedMessagesOnConsumerTenant) (nonPersistentTopicsGetMaxUnackedMessagesOnConsumerNamespace) (nonPersistentTopicsGetMaxUnackedMessagesOnConsumerTopic) (nonPersistentTopicsGetMaxUnackedMessagesOnConsumerApplied) (nonPersistentTopicsGetMaxUnackedMessagesOnConsumerIsGlobal) (nonPersistentTopicsGetMaxUnackedMessagesOnConsumerAuthoritative)

-- ^ 
type NonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnSubscription" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters = NonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters
  { nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionTenant :: Text -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionNamespace :: Text -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionTopic :: Text -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMaxUnackedMessagesOnSubscription :: NonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters -> ClientM Int
nonPersistentTopicsGetMaxUnackedMessagesOnSubscription NonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionAPI) (nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionTenant) (nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionNamespace) (nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionTopic) (nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionApplied) (nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionIsGlobal) (nonPersistentTopicsGetMaxUnackedMessagesOnSubscriptionAuthoritative)

-- ^ 
type NonPersistentTopicsGetMessageByIdAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "ledger" :> Capture "ledgerId" Integer :> "entry" :> Capture "entryId" Integer :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] NoContent

data NonPersistentTopicsGetMessageByIdParameters = NonPersistentTopicsGetMessageByIdParameters
  { nonPersistentTopicsGetMessageByIdTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetMessageByIdNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetMessageByIdTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetMessageByIdLedgerId :: Integer -- ^ The ledger id
  , nonPersistentTopicsGetMessageByIdEntryId :: Integer -- ^ The entry id
  , nonPersistentTopicsGetMessageByIdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMessageById :: NonPersistentTopicsGetMessageByIdParameters -> ClientM NoContent
nonPersistentTopicsGetMessageById NonPersistentTopicsGetMessageByIdParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMessageByIdAPI) (nonPersistentTopicsGetMessageByIdTenant) (nonPersistentTopicsGetMessageByIdNamespace) (nonPersistentTopicsGetMessageByIdTopic) (nonPersistentTopicsGetMessageByIdLedgerId) (nonPersistentTopicsGetMessageByIdEntryId) (nonPersistentTopicsGetMessageByIdAuthoritative)

-- ^ 
type NonPersistentTopicsGetMessageIdByTimestampAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "messageid" :> Capture "timestamp" Integer :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] MessageIdAdv

data NonPersistentTopicsGetMessageIdByTimestampParameters = NonPersistentTopicsGetMessageIdByTimestampParameters
  { nonPersistentTopicsGetMessageIdByTimestampTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetMessageIdByTimestampNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetMessageIdByTimestampTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetMessageIdByTimestampTimestamp :: Integer -- ^ Specify the timestamp
  , nonPersistentTopicsGetMessageIdByTimestampAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMessageIdByTimestamp :: NonPersistentTopicsGetMessageIdByTimestampParameters -> ClientM MessageIdAdv
nonPersistentTopicsGetMessageIdByTimestamp NonPersistentTopicsGetMessageIdByTimestampParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMessageIdByTimestampAPI) (nonPersistentTopicsGetMessageIdByTimestampTenant) (nonPersistentTopicsGetMessageIdByTimestampNamespace) (nonPersistentTopicsGetMessageIdByTimestampTopic) (nonPersistentTopicsGetMessageIdByTimestampTimestamp) (nonPersistentTopicsGetMessageIdByTimestampAuthoritative)

-- ^ 
type NonPersistentTopicsGetMessageTTLAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "messageTTL" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data NonPersistentTopicsGetMessageTTLParameters = NonPersistentTopicsGetMessageTTLParameters
  { nonPersistentTopicsGetMessageTTLTenant :: Text -- ^ 
  , nonPersistentTopicsGetMessageTTLNamespace :: Text -- ^ 
  , nonPersistentTopicsGetMessageTTLTopic :: Text -- ^ 
  , nonPersistentTopicsGetMessageTTLApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMessageTTLIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetMessageTTLAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetMessageTTL :: NonPersistentTopicsGetMessageTTLParameters -> ClientM Int
nonPersistentTopicsGetMessageTTL NonPersistentTopicsGetMessageTTLParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetMessageTTLAPI) (nonPersistentTopicsGetMessageTTLTenant) (nonPersistentTopicsGetMessageTTLNamespace) (nonPersistentTopicsGetMessageTTLTopic) (nonPersistentTopicsGetMessageTTLApplied) (nonPersistentTopicsGetMessageTTLIsGlobal) (nonPersistentTopicsGetMessageTTLAuthoritative)

-- ^ 
type NonPersistentTopicsGetOffloadPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offloadPolicies" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] OffloadPoliciesImpl

data NonPersistentTopicsGetOffloadPoliciesParameters = NonPersistentTopicsGetOffloadPoliciesParameters
  { nonPersistentTopicsGetOffloadPoliciesTenant :: Text -- ^ 
  , nonPersistentTopicsGetOffloadPoliciesNamespace :: Text -- ^ 
  , nonPersistentTopicsGetOffloadPoliciesTopic :: Text -- ^ 
  , nonPersistentTopicsGetOffloadPoliciesApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetOffloadPoliciesIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetOffloadPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetOffloadPolicies :: NonPersistentTopicsGetOffloadPoliciesParameters -> ClientM OffloadPoliciesImpl
nonPersistentTopicsGetOffloadPolicies NonPersistentTopicsGetOffloadPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetOffloadPoliciesAPI) (nonPersistentTopicsGetOffloadPoliciesTenant) (nonPersistentTopicsGetOffloadPoliciesNamespace) (nonPersistentTopicsGetOffloadPoliciesTopic) (nonPersistentTopicsGetOffloadPoliciesApplied) (nonPersistentTopicsGetOffloadPoliciesIsGlobal) (nonPersistentTopicsGetOffloadPoliciesAuthoritative)

-- ^ 
type NonPersistentTopicsGetPartitionedMetadataAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitions" :> QueryParam "authoritative" Bool :> QueryParam "checkAllowAutoCreation" Bool :> Verb 'GET 200 '[JSON] PartitionedTopicMetadata

data NonPersistentTopicsGetPartitionedMetadataParameters = NonPersistentTopicsGetPartitionedMetadataParameters
  { nonPersistentTopicsGetPartitionedMetadataTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetPartitionedMetadataNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetPartitionedMetadataTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetPartitionedMetadataAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsGetPartitionedMetadataCheckAllowAutoCreation :: Maybe Bool -- ^ Is check configuration required to automatically create topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetPartitionedMetadata :: NonPersistentTopicsGetPartitionedMetadataParameters -> ClientM PartitionedTopicMetadata
nonPersistentTopicsGetPartitionedMetadata NonPersistentTopicsGetPartitionedMetadataParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetPartitionedMetadataAPI) (nonPersistentTopicsGetPartitionedMetadataTenant) (nonPersistentTopicsGetPartitionedMetadataNamespace) (nonPersistentTopicsGetPartitionedMetadataTopic) (nonPersistentTopicsGetPartitionedMetadataAuthoritative) (nonPersistentTopicsGetPartitionedMetadataCheckAllowAutoCreation)

-- ^ 
type NonPersistentTopicsGetPartitionedStatsAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitioned-stats" :> QueryParam "perPartition" Bool :> QueryParam "authoritative" Bool :> QueryParam "getPreciseBacklog" Bool :> QueryParam "subscriptionBacklogSize" Bool :> QueryParam "getEarliestTimeInBacklog" Bool :> QueryParam "excludePublishers" Bool :> QueryParam "excludeConsumers" Bool :> Verb 'GET 200 '[JSON] NonPersistentPartitionedTopicStatsImpl

data NonPersistentTopicsGetPartitionedStatsParameters = NonPersistentTopicsGetPartitionedStatsParameters
  { nonPersistentTopicsGetPartitionedStatsTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetPartitionedStatsNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetPartitionedStatsTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetPartitionedStatsPerPartition :: Maybe Bool -- ^ Get per partition stats
  , nonPersistentTopicsGetPartitionedStatsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsGetPartitionedStatsGetPreciseBacklog :: Maybe Bool -- ^ If return precise backlog or imprecise backlog
  , nonPersistentTopicsGetPartitionedStatsSubscriptionBacklogSize :: Maybe Bool -- ^ If return backlog size for each subscription, require locking on ledger so be careful not to use when there's heavy traffic.
  , nonPersistentTopicsGetPartitionedStatsGetEarliestTimeInBacklog :: Maybe Bool -- ^ If return the earliest time in backlog
  , nonPersistentTopicsGetPartitionedStatsExcludePublishers :: Maybe Bool -- ^ If exclude the publishers
  , nonPersistentTopicsGetPartitionedStatsExcludeConsumers :: Maybe Bool -- ^ If exclude the consumers
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetPartitionedStats :: NonPersistentTopicsGetPartitionedStatsParameters -> ClientM NonPersistentPartitionedTopicStatsImpl
nonPersistentTopicsGetPartitionedStats NonPersistentTopicsGetPartitionedStatsParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetPartitionedStatsAPI) (nonPersistentTopicsGetPartitionedStatsTenant) (nonPersistentTopicsGetPartitionedStatsNamespace) (nonPersistentTopicsGetPartitionedStatsTopic) (nonPersistentTopicsGetPartitionedStatsPerPartition) (nonPersistentTopicsGetPartitionedStatsAuthoritative) (nonPersistentTopicsGetPartitionedStatsGetPreciseBacklog) (nonPersistentTopicsGetPartitionedStatsSubscriptionBacklogSize) (nonPersistentTopicsGetPartitionedStatsGetEarliestTimeInBacklog) (nonPersistentTopicsGetPartitionedStatsExcludePublishers) (nonPersistentTopicsGetPartitionedStatsExcludeConsumers)

-- ^ 
type NonPersistentTopicsGetPartitionedStatsInternalAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitioned-internalStats" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PartitionedTopicInternalStats

data NonPersistentTopicsGetPartitionedStatsInternalParameters = NonPersistentTopicsGetPartitionedStatsInternalParameters
  { nonPersistentTopicsGetPartitionedStatsInternalTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetPartitionedStatsInternalNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetPartitionedStatsInternalTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetPartitionedStatsInternalAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetPartitionedStatsInternal :: NonPersistentTopicsGetPartitionedStatsInternalParameters -> ClientM PartitionedTopicInternalStats
nonPersistentTopicsGetPartitionedStatsInternal NonPersistentTopicsGetPartitionedStatsInternalParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetPartitionedStatsInternalAPI) (nonPersistentTopicsGetPartitionedStatsInternalTenant) (nonPersistentTopicsGetPartitionedStatsInternalNamespace) (nonPersistentTopicsGetPartitionedStatsInternalTopic) (nonPersistentTopicsGetPartitionedStatsInternalAuthoritative)

-- ^ 
type NonPersistentTopicsGetPartitionedTopicListAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> "partitioned" :> QueryParam "includeSystemTopic" Bool :> Verb 'GET 200 '[JSON] [Text]

data NonPersistentTopicsGetPartitionedTopicListParameters = NonPersistentTopicsGetPartitionedTopicListParameters
  { nonPersistentTopicsGetPartitionedTopicListTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetPartitionedTopicListNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetPartitionedTopicListIncludeSystemTopic :: Maybe Bool -- ^ Include system topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetPartitionedTopicList :: NonPersistentTopicsGetPartitionedTopicListParameters -> ClientM [Text]
nonPersistentTopicsGetPartitionedTopicList NonPersistentTopicsGetPartitionedTopicListParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetPartitionedTopicListAPI) (nonPersistentTopicsGetPartitionedTopicListTenant) (nonPersistentTopicsGetPartitionedTopicListNamespace) (nonPersistentTopicsGetPartitionedTopicListIncludeSystemTopic)

-- ^ Retrieve the effective permissions for a topic. These permissions are defined by the permissions set at thenamespace level combined (union) with any eventual specific permission set on the topic.Returns a nested map structure which Swagger does not fully support for display. Structure: Map<String, Set<AuthAction>>. Please refer to this structure for details.
type NonPersistentTopicsGetPermissionsOnTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "permissions" :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

data NonPersistentTopicsGetPermissionsOnTopicParameters = NonPersistentTopicsGetPermissionsOnTopicParameters
  { nonPersistentTopicsGetPermissionsOnTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetPermissionsOnTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetPermissionsOnTopicTopic :: Text -- ^ Specify topic name
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetPermissionsOnTopic :: NonPersistentTopicsGetPermissionsOnTopicParameters -> ClientM (Map.Map String Text)
nonPersistentTopicsGetPermissionsOnTopic NonPersistentTopicsGetPermissionsOnTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetPermissionsOnTopicAPI) (nonPersistentTopicsGetPermissionsOnTopicTenant) (nonPersistentTopicsGetPermissionsOnTopicNamespace) (nonPersistentTopicsGetPermissionsOnTopicTopic)

-- ^ 
type NonPersistentTopicsGetPersistenceAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "persistence" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PersistencePolicies

data NonPersistentTopicsGetPersistenceParameters = NonPersistentTopicsGetPersistenceParameters
  { nonPersistentTopicsGetPersistenceTenant :: Text -- ^ 
  , nonPersistentTopicsGetPersistenceNamespace :: Text -- ^ 
  , nonPersistentTopicsGetPersistenceTopic :: Text -- ^ 
  , nonPersistentTopicsGetPersistenceApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetPersistenceIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetPersistenceAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetPersistence :: NonPersistentTopicsGetPersistenceParameters -> ClientM PersistencePolicies
nonPersistentTopicsGetPersistence NonPersistentTopicsGetPersistenceParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetPersistenceAPI) (nonPersistentTopicsGetPersistenceTenant) (nonPersistentTopicsGetPersistenceNamespace) (nonPersistentTopicsGetPersistenceTopic) (nonPersistentTopicsGetPersistenceApplied) (nonPersistentTopicsGetPersistenceIsGlobal) (nonPersistentTopicsGetPersistenceAuthoritative)

-- ^ 
type NonPersistentTopicsGetPropertiesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "properties" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

data NonPersistentTopicsGetPropertiesParameters = NonPersistentTopicsGetPropertiesParameters
  { nonPersistentTopicsGetPropertiesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetPropertiesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetPropertiesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetPropertiesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetProperties :: NonPersistentTopicsGetPropertiesParameters -> ClientM (Map.Map String Text)
nonPersistentTopicsGetProperties NonPersistentTopicsGetPropertiesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetPropertiesAPI) (nonPersistentTopicsGetPropertiesTenant) (nonPersistentTopicsGetPropertiesNamespace) (nonPersistentTopicsGetPropertiesTopic) (nonPersistentTopicsGetPropertiesAuthoritative)

-- ^ 
type NonPersistentTopicsGetPublishRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "publishRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PublishRate

data NonPersistentTopicsGetPublishRateParameters = NonPersistentTopicsGetPublishRateParameters
  { nonPersistentTopicsGetPublishRateTenant :: Text -- ^ 
  , nonPersistentTopicsGetPublishRateNamespace :: Text -- ^ 
  , nonPersistentTopicsGetPublishRateTopic :: Text -- ^ 
  , nonPersistentTopicsGetPublishRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetPublishRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetPublishRate :: NonPersistentTopicsGetPublishRateParameters -> ClientM PublishRate
nonPersistentTopicsGetPublishRate NonPersistentTopicsGetPublishRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetPublishRateAPI) (nonPersistentTopicsGetPublishRateTenant) (nonPersistentTopicsGetPublishRateNamespace) (nonPersistentTopicsGetPublishRateTopic) (nonPersistentTopicsGetPublishRateIsGlobal) (nonPersistentTopicsGetPublishRateAuthoritative)

-- ^ 
type NonPersistentTopicsGetReplicatedSubscriptionStatusAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "replicatedSubscriptionStatus" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] ((Map.Map String Bool))

data NonPersistentTopicsGetReplicatedSubscriptionStatusParameters = NonPersistentTopicsGetReplicatedSubscriptionStatusParameters
  { nonPersistentTopicsGetReplicatedSubscriptionStatusTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetReplicatedSubscriptionStatusNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetReplicatedSubscriptionStatusTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetReplicatedSubscriptionStatusSubName :: Text -- ^ Name of subscription
  , nonPersistentTopicsGetReplicatedSubscriptionStatusAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetReplicatedSubscriptionStatus :: NonPersistentTopicsGetReplicatedSubscriptionStatusParameters -> ClientM (Map.Map String Bool)
nonPersistentTopicsGetReplicatedSubscriptionStatus NonPersistentTopicsGetReplicatedSubscriptionStatusParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetReplicatedSubscriptionStatusAPI) (nonPersistentTopicsGetReplicatedSubscriptionStatusTenant) (nonPersistentTopicsGetReplicatedSubscriptionStatusNamespace) (nonPersistentTopicsGetReplicatedSubscriptionStatusTopic) (nonPersistentTopicsGetReplicatedSubscriptionStatusSubName) (nonPersistentTopicsGetReplicatedSubscriptionStatusAuthoritative)

-- ^ 
type NonPersistentTopicsGetReplicationClustersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replication" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] [Text]

data NonPersistentTopicsGetReplicationClustersParameters = NonPersistentTopicsGetReplicationClustersParameters
  { nonPersistentTopicsGetReplicationClustersTenant :: Text -- ^ 
  , nonPersistentTopicsGetReplicationClustersNamespace :: Text -- ^ 
  , nonPersistentTopicsGetReplicationClustersTopic :: Text -- ^ 
  , nonPersistentTopicsGetReplicationClustersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetReplicationClustersApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetReplicationClustersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetReplicationClusters :: NonPersistentTopicsGetReplicationClustersParameters -> ClientM [Text]
nonPersistentTopicsGetReplicationClusters NonPersistentTopicsGetReplicationClustersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetReplicationClustersAPI) (nonPersistentTopicsGetReplicationClustersTenant) (nonPersistentTopicsGetReplicationClustersNamespace) (nonPersistentTopicsGetReplicationClustersTopic) (nonPersistentTopicsGetReplicationClustersIsGlobal) (nonPersistentTopicsGetReplicationClustersApplied) (nonPersistentTopicsGetReplicationClustersAuthoritative)

-- ^ 
type NonPersistentTopicsGetReplicatorDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replicatorDispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DispatchRate

data NonPersistentTopicsGetReplicatorDispatchRateParameters = NonPersistentTopicsGetReplicatorDispatchRateParameters
  { nonPersistentTopicsGetReplicatorDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsGetReplicatorDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsGetReplicatorDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsGetReplicatorDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetReplicatorDispatchRateApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetReplicatorDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetReplicatorDispatchRate :: NonPersistentTopicsGetReplicatorDispatchRateParameters -> ClientM DispatchRate
nonPersistentTopicsGetReplicatorDispatchRate NonPersistentTopicsGetReplicatorDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetReplicatorDispatchRateAPI) (nonPersistentTopicsGetReplicatorDispatchRateTenant) (nonPersistentTopicsGetReplicatorDispatchRateNamespace) (nonPersistentTopicsGetReplicatorDispatchRateTopic) (nonPersistentTopicsGetReplicatorDispatchRateIsGlobal) (nonPersistentTopicsGetReplicatorDispatchRateApplied) (nonPersistentTopicsGetReplicatorDispatchRateAuthoritative)

-- ^ 
type NonPersistentTopicsGetRetentionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "retention" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] RetentionPolicies

data NonPersistentTopicsGetRetentionParameters = NonPersistentTopicsGetRetentionParameters
  { nonPersistentTopicsGetRetentionTenant :: Text -- ^ 
  , nonPersistentTopicsGetRetentionNamespace :: Text -- ^ 
  , nonPersistentTopicsGetRetentionTopic :: Text -- ^ 
  , nonPersistentTopicsGetRetentionIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetRetentionApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetRetentionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetRetention :: NonPersistentTopicsGetRetentionParameters -> ClientM RetentionPolicies
nonPersistentTopicsGetRetention NonPersistentTopicsGetRetentionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetRetentionAPI) (nonPersistentTopicsGetRetentionTenant) (nonPersistentTopicsGetRetentionNamespace) (nonPersistentTopicsGetRetentionTopic) (nonPersistentTopicsGetRetentionIsGlobal) (nonPersistentTopicsGetRetentionApplied) (nonPersistentTopicsGetRetentionAuthoritative)

-- ^ 
type NonPersistentTopicsGetSchemaCompatibilityStrategyAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaCompatibilityStrategy" :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Text

data NonPersistentTopicsGetSchemaCompatibilityStrategyParameters = NonPersistentTopicsGetSchemaCompatibilityStrategyParameters
  { nonPersistentTopicsGetSchemaCompatibilityStrategyTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetSchemaCompatibilityStrategyNamespace :: Text -- ^ Specify the cluster
  , nonPersistentTopicsGetSchemaCompatibilityStrategyTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetSchemaCompatibilityStrategyApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetSchemaCompatibilityStrategyAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetSchemaCompatibilityStrategy :: NonPersistentTopicsGetSchemaCompatibilityStrategyParameters -> ClientM Text
nonPersistentTopicsGetSchemaCompatibilityStrategy NonPersistentTopicsGetSchemaCompatibilityStrategyParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetSchemaCompatibilityStrategyAPI) (nonPersistentTopicsGetSchemaCompatibilityStrategyTenant) (nonPersistentTopicsGetSchemaCompatibilityStrategyNamespace) (nonPersistentTopicsGetSchemaCompatibilityStrategyTopic) (nonPersistentTopicsGetSchemaCompatibilityStrategyApplied) (nonPersistentTopicsGetSchemaCompatibilityStrategyAuthoritative)

-- ^ 
type NonPersistentTopicsGetSchemaValidationEnforcedAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaValidationEnforced" :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Bool

data NonPersistentTopicsGetSchemaValidationEnforcedParameters = NonPersistentTopicsGetSchemaValidationEnforcedParameters
  { nonPersistentTopicsGetSchemaValidationEnforcedTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetSchemaValidationEnforcedNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetSchemaValidationEnforcedTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetSchemaValidationEnforcedApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetSchemaValidationEnforcedAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetSchemaValidationEnforced :: NonPersistentTopicsGetSchemaValidationEnforcedParameters -> ClientM Bool
nonPersistentTopicsGetSchemaValidationEnforced NonPersistentTopicsGetSchemaValidationEnforcedParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetSchemaValidationEnforcedAPI) (nonPersistentTopicsGetSchemaValidationEnforcedTenant) (nonPersistentTopicsGetSchemaValidationEnforcedNamespace) (nonPersistentTopicsGetSchemaValidationEnforcedTopic) (nonPersistentTopicsGetSchemaValidationEnforcedApplied) (nonPersistentTopicsGetSchemaValidationEnforcedAuthoritative)

-- ^ 
type NonPersistentTopicsGetShadowTopicsAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "shadowTopics" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] [Text]

data NonPersistentTopicsGetShadowTopicsParameters = NonPersistentTopicsGetShadowTopicsParameters
  { nonPersistentTopicsGetShadowTopicsTenant :: Text -- ^ 
  , nonPersistentTopicsGetShadowTopicsNamespace :: Text -- ^ 
  , nonPersistentTopicsGetShadowTopicsTopic :: Text -- ^ 
  , nonPersistentTopicsGetShadowTopicsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetShadowTopics :: NonPersistentTopicsGetShadowTopicsParameters -> ClientM [Text]
nonPersistentTopicsGetShadowTopics NonPersistentTopicsGetShadowTopicsParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetShadowTopicsAPI) (nonPersistentTopicsGetShadowTopicsTenant) (nonPersistentTopicsGetShadowTopicsNamespace) (nonPersistentTopicsGetShadowTopicsTopic) (nonPersistentTopicsGetShadowTopicsAuthoritative)

-- ^ 
type NonPersistentTopicsGetStatsAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "stats" :> QueryParam "authoritative" Bool :> QueryParam "getPreciseBacklog" Bool :> QueryParam "subscriptionBacklogSize" Bool :> QueryParam "getEarliestTimeInBacklog" Bool :> QueryParam "excludePublishers" Bool :> QueryParam "excludeConsumers" Bool :> Verb 'GET 200 '[JSON] PersistentTopicStats

data NonPersistentTopicsGetStatsParameters = NonPersistentTopicsGetStatsParameters
  { nonPersistentTopicsGetStatsTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetStatsNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetStatsTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetStatsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsGetStatsGetPreciseBacklog :: Maybe Bool -- ^ If return precise backlog or imprecise backlog
  , nonPersistentTopicsGetStatsSubscriptionBacklogSize :: Maybe Bool -- ^ If return backlog size for each subscription, require locking on ledger so be careful not to use when there's heavy traffic.
  , nonPersistentTopicsGetStatsGetEarliestTimeInBacklog :: Maybe Bool -- ^ If return time of the earliest message in backlog
  , nonPersistentTopicsGetStatsExcludePublishers :: Maybe Bool -- ^ If exclude the publishers
  , nonPersistentTopicsGetStatsExcludeConsumers :: Maybe Bool -- ^ If exclude the consumers
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetStats :: NonPersistentTopicsGetStatsParameters -> ClientM PersistentTopicStats
nonPersistentTopicsGetStats NonPersistentTopicsGetStatsParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetStatsAPI) (nonPersistentTopicsGetStatsTenant) (nonPersistentTopicsGetStatsNamespace) (nonPersistentTopicsGetStatsTopic) (nonPersistentTopicsGetStatsAuthoritative) (nonPersistentTopicsGetStatsGetPreciseBacklog) (nonPersistentTopicsGetStatsSubscriptionBacklogSize) (nonPersistentTopicsGetStatsGetEarliestTimeInBacklog) (nonPersistentTopicsGetStatsExcludePublishers) (nonPersistentTopicsGetStatsExcludeConsumers)

-- ^ 
type NonPersistentTopicsGetSubscribeRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscribeRate" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] SubscribeRate

data NonPersistentTopicsGetSubscribeRateParameters = NonPersistentTopicsGetSubscribeRateParameters
  { nonPersistentTopicsGetSubscribeRateTenant :: Text -- ^ 
  , nonPersistentTopicsGetSubscribeRateNamespace :: Text -- ^ 
  , nonPersistentTopicsGetSubscribeRateTopic :: Text -- ^ 
  , nonPersistentTopicsGetSubscribeRateApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetSubscribeRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetSubscribeRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetSubscribeRate :: NonPersistentTopicsGetSubscribeRateParameters -> ClientM SubscribeRate
nonPersistentTopicsGetSubscribeRate NonPersistentTopicsGetSubscribeRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetSubscribeRateAPI) (nonPersistentTopicsGetSubscribeRateTenant) (nonPersistentTopicsGetSubscribeRateNamespace) (nonPersistentTopicsGetSubscribeRateTopic) (nonPersistentTopicsGetSubscribeRateApplied) (nonPersistentTopicsGetSubscribeRateIsGlobal) (nonPersistentTopicsGetSubscribeRateAuthoritative)

-- ^ 
type NonPersistentTopicsGetSubscriptionDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionDispatchRate" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DispatchRate

data NonPersistentTopicsGetSubscriptionDispatchRateParameters = NonPersistentTopicsGetSubscriptionDispatchRateParameters
  { nonPersistentTopicsGetSubscriptionDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionDispatchRateApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetSubscriptionDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetSubscriptionDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetSubscriptionDispatchRate :: NonPersistentTopicsGetSubscriptionDispatchRateParameters -> ClientM DispatchRate
nonPersistentTopicsGetSubscriptionDispatchRate NonPersistentTopicsGetSubscriptionDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetSubscriptionDispatchRateAPI) (nonPersistentTopicsGetSubscriptionDispatchRateTenant) (nonPersistentTopicsGetSubscriptionDispatchRateNamespace) (nonPersistentTopicsGetSubscriptionDispatchRateTopic) (nonPersistentTopicsGetSubscriptionDispatchRateApplied) (nonPersistentTopicsGetSubscriptionDispatchRateIsGlobal) (nonPersistentTopicsGetSubscriptionDispatchRateAuthoritative)

-- ^ 
type NonPersistentTopicsGetSubscriptionLevelDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> Capture "subName" Text :> "dispatchRate" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DispatchRate

data NonPersistentTopicsGetSubscriptionLevelDispatchRateParameters = NonPersistentTopicsGetSubscriptionLevelDispatchRateParameters
  { nonPersistentTopicsGetSubscriptionLevelDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionLevelDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionLevelDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionLevelDispatchRateSubName :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionLevelDispatchRateApplied :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetSubscriptionLevelDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetSubscriptionLevelDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetSubscriptionLevelDispatchRate :: NonPersistentTopicsGetSubscriptionLevelDispatchRateParameters -> ClientM DispatchRate
nonPersistentTopicsGetSubscriptionLevelDispatchRate NonPersistentTopicsGetSubscriptionLevelDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetSubscriptionLevelDispatchRateAPI) (nonPersistentTopicsGetSubscriptionLevelDispatchRateTenant) (nonPersistentTopicsGetSubscriptionLevelDispatchRateNamespace) (nonPersistentTopicsGetSubscriptionLevelDispatchRateTopic) (nonPersistentTopicsGetSubscriptionLevelDispatchRateSubName) (nonPersistentTopicsGetSubscriptionLevelDispatchRateApplied) (nonPersistentTopicsGetSubscriptionLevelDispatchRateIsGlobal) (nonPersistentTopicsGetSubscriptionLevelDispatchRateAuthoritative)

-- ^ 
type NonPersistentTopicsGetSubscriptionPropertiesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "properties" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

data NonPersistentTopicsGetSubscriptionPropertiesParameters = NonPersistentTopicsGetSubscriptionPropertiesParameters
  { nonPersistentTopicsGetSubscriptionPropertiesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetSubscriptionPropertiesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetSubscriptionPropertiesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetSubscriptionPropertiesSubName :: Text -- ^ Subscription
  , nonPersistentTopicsGetSubscriptionPropertiesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetSubscriptionProperties :: NonPersistentTopicsGetSubscriptionPropertiesParameters -> ClientM (Map.Map String Text)
nonPersistentTopicsGetSubscriptionProperties NonPersistentTopicsGetSubscriptionPropertiesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetSubscriptionPropertiesAPI) (nonPersistentTopicsGetSubscriptionPropertiesTenant) (nonPersistentTopicsGetSubscriptionPropertiesNamespace) (nonPersistentTopicsGetSubscriptionPropertiesTopic) (nonPersistentTopicsGetSubscriptionPropertiesSubName) (nonPersistentTopicsGetSubscriptionPropertiesAuthoritative)

-- ^ 
type NonPersistentTopicsGetSubscriptionTypesEnabledAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionTypesEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] [Text]

data NonPersistentTopicsGetSubscriptionTypesEnabledParameters = NonPersistentTopicsGetSubscriptionTypesEnabledParameters
  { nonPersistentTopicsGetSubscriptionTypesEnabledTenant :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionTypesEnabledNamespace :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionTypesEnabledTopic :: Text -- ^ 
  , nonPersistentTopicsGetSubscriptionTypesEnabledIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsGetSubscriptionTypesEnabledAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetSubscriptionTypesEnabled :: NonPersistentTopicsGetSubscriptionTypesEnabledParameters -> ClientM [Text]
nonPersistentTopicsGetSubscriptionTypesEnabled NonPersistentTopicsGetSubscriptionTypesEnabledParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetSubscriptionTypesEnabledAPI) (nonPersistentTopicsGetSubscriptionTypesEnabledTenant) (nonPersistentTopicsGetSubscriptionTypesEnabledNamespace) (nonPersistentTopicsGetSubscriptionTypesEnabledTopic) (nonPersistentTopicsGetSubscriptionTypesEnabledIsGlobal) (nonPersistentTopicsGetSubscriptionTypesEnabledAuthoritative)

-- ^ 
type NonPersistentTopicsGetSubscriptionsAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptions" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] [Text]

data NonPersistentTopicsGetSubscriptionsParameters = NonPersistentTopicsGetSubscriptionsParameters
  { nonPersistentTopicsGetSubscriptionsTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGetSubscriptionsNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGetSubscriptionsTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGetSubscriptionsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGetSubscriptions :: NonPersistentTopicsGetSubscriptionsParameters -> ClientM [Text]
nonPersistentTopicsGetSubscriptions NonPersistentTopicsGetSubscriptionsParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGetSubscriptionsAPI) (nonPersistentTopicsGetSubscriptionsTenant) (nonPersistentTopicsGetSubscriptionsNamespace) (nonPersistentTopicsGetSubscriptionsTopic) (nonPersistentTopicsGetSubscriptionsAuthoritative)

-- ^ 
type NonPersistentTopicsGrantPermissionsOnTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "permissions" :> Capture "role" Text :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsGrantPermissionsOnTopicParameters = NonPersistentTopicsGrantPermissionsOnTopicParameters
  { nonPersistentTopicsGrantPermissionsOnTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsGrantPermissionsOnTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsGrantPermissionsOnTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsGrantPermissionsOnTopicRole :: Text -- ^ Client role to which grant permissions
  , nonPersistentTopicsGrantPermissionsOnTopicBody :: [Text] -- ^ Actions to be granted (produce,functions,consume)
  } deriving (Show, Eq, Generic)

nonPersistentTopicsGrantPermissionsOnTopic :: NonPersistentTopicsGrantPermissionsOnTopicParameters -> ClientM NoContent
nonPersistentTopicsGrantPermissionsOnTopic NonPersistentTopicsGrantPermissionsOnTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsGrantPermissionsOnTopicAPI) (nonPersistentTopicsGrantPermissionsOnTopicTenant) (nonPersistentTopicsGrantPermissionsOnTopicNamespace) (nonPersistentTopicsGrantPermissionsOnTopicTopic) (nonPersistentTopicsGrantPermissionsOnTopicRole) nonPersistentTopicsGrantPermissionsOnTopicBody

-- ^ 
type NonPersistentTopicsOffloadStatusAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offload" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] OffloadProcessStatus

data NonPersistentTopicsOffloadStatusParameters = NonPersistentTopicsOffloadStatusParameters
  { nonPersistentTopicsOffloadStatusTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsOffloadStatusNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsOffloadStatusTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsOffloadStatusAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsOffloadStatus :: NonPersistentTopicsOffloadStatusParameters -> ClientM OffloadProcessStatus
nonPersistentTopicsOffloadStatus NonPersistentTopicsOffloadStatusParameters {..} = client (Proxy :: Proxy NonPersistentTopicsOffloadStatusAPI) (nonPersistentTopicsOffloadStatusTenant) (nonPersistentTopicsOffloadStatusNamespace) (nonPersistentTopicsOffloadStatusTopic) (nonPersistentTopicsOffloadStatusAuthoritative)

-- ^ 
type NonPersistentTopicsPeekNthMessageAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "position" :> Capture "messagePosition" Int :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] NoContent

data NonPersistentTopicsPeekNthMessageParameters = NonPersistentTopicsPeekNthMessageParameters
  { nonPersistentTopicsPeekNthMessageTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsPeekNthMessageNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsPeekNthMessageTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsPeekNthMessageSubName :: Text -- ^ Subscribed message expired
  , nonPersistentTopicsPeekNthMessageMessagePosition :: Int -- ^ The number of messages (default 1)
  , nonPersistentTopicsPeekNthMessageAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsPeekNthMessage :: NonPersistentTopicsPeekNthMessageParameters -> ClientM NoContent
nonPersistentTopicsPeekNthMessage NonPersistentTopicsPeekNthMessageParameters {..} = client (Proxy :: Proxy NonPersistentTopicsPeekNthMessageAPI) (nonPersistentTopicsPeekNthMessageTenant) (nonPersistentTopicsPeekNthMessageNamespace) (nonPersistentTopicsPeekNthMessageTopic) (nonPersistentTopicsPeekNthMessageSubName) (nonPersistentTopicsPeekNthMessageMessagePosition) (nonPersistentTopicsPeekNthMessageAuthoritative)

-- ^ 
type NonPersistentTopicsPostExpireTopicMessagesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "expireMessages" :> Capture "expireTimeInSeconds" Int :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsPostExpireTopicMessagesParameters = NonPersistentTopicsPostExpireTopicMessagesParameters
  { nonPersistentTopicsPostExpireTopicMessagesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsPostExpireTopicMessagesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsPostExpireTopicMessagesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsPostExpireTopicMessagesSubName :: Text -- ^ Subscription to be Expiry messages on
  , nonPersistentTopicsPostExpireTopicMessagesExpireTimeInSeconds :: Int -- ^ Expires beyond the specified number of seconds
  , nonPersistentTopicsPostExpireTopicMessagesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsPostExpireTopicMessages :: NonPersistentTopicsPostExpireTopicMessagesParameters -> ClientM NoContent
nonPersistentTopicsPostExpireTopicMessages NonPersistentTopicsPostExpireTopicMessagesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsPostExpireTopicMessagesAPI) (nonPersistentTopicsPostExpireTopicMessagesTenant) (nonPersistentTopicsPostExpireTopicMessagesNamespace) (nonPersistentTopicsPostExpireTopicMessagesTopic) (nonPersistentTopicsPostExpireTopicMessagesSubName) (nonPersistentTopicsPostExpireTopicMessagesExpireTimeInSeconds) (nonPersistentTopicsPostExpireTopicMessagesAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveAutoSubscriptionCreationAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "autoSubscriptionCreation" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveAutoSubscriptionCreationParameters = NonPersistentTopicsRemoveAutoSubscriptionCreationParameters
  { nonPersistentTopicsRemoveAutoSubscriptionCreationTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveAutoSubscriptionCreationNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveAutoSubscriptionCreationTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveAutoSubscriptionCreationIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveAutoSubscriptionCreationAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveAutoSubscriptionCreation :: NonPersistentTopicsRemoveAutoSubscriptionCreationParameters -> ClientM NoContent
nonPersistentTopicsRemoveAutoSubscriptionCreation NonPersistentTopicsRemoveAutoSubscriptionCreationParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveAutoSubscriptionCreationAPI) (nonPersistentTopicsRemoveAutoSubscriptionCreationTenant) (nonPersistentTopicsRemoveAutoSubscriptionCreationNamespace) (nonPersistentTopicsRemoveAutoSubscriptionCreationTopic) (nonPersistentTopicsRemoveAutoSubscriptionCreationIsGlobal) (nonPersistentTopicsRemoveAutoSubscriptionCreationAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveBacklogQuotaAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlogQuota" :> QueryParam "backlogQuotaType" Text :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveBacklogQuotaParameters = NonPersistentTopicsRemoveBacklogQuotaParameters
  { nonPersistentTopicsRemoveBacklogQuotaTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveBacklogQuotaNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveBacklogQuotaTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveBacklogQuotaBacklogQuotaType :: Maybe Text -- ^ 
  , nonPersistentTopicsRemoveBacklogQuotaAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsRemoveBacklogQuotaIsGlobal :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveBacklogQuota :: NonPersistentTopicsRemoveBacklogQuotaParameters -> ClientM NoContent
nonPersistentTopicsRemoveBacklogQuota NonPersistentTopicsRemoveBacklogQuotaParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveBacklogQuotaAPI) (nonPersistentTopicsRemoveBacklogQuotaTenant) (nonPersistentTopicsRemoveBacklogQuotaNamespace) (nonPersistentTopicsRemoveBacklogQuotaTopic) (nonPersistentTopicsRemoveBacklogQuotaBacklogQuotaType) (nonPersistentTopicsRemoveBacklogQuotaAuthoritative) (nonPersistentTopicsRemoveBacklogQuotaIsGlobal)

-- ^ 
type NonPersistentTopicsRemoveCompactionThresholdAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compactionThreshold" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveCompactionThresholdParameters = NonPersistentTopicsRemoveCompactionThresholdParameters
  { nonPersistentTopicsRemoveCompactionThresholdTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveCompactionThresholdNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveCompactionThresholdTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveCompactionThresholdIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveCompactionThresholdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveCompactionThreshold :: NonPersistentTopicsRemoveCompactionThresholdParameters -> ClientM NoContent
nonPersistentTopicsRemoveCompactionThreshold NonPersistentTopicsRemoveCompactionThresholdParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveCompactionThresholdAPI) (nonPersistentTopicsRemoveCompactionThresholdTenant) (nonPersistentTopicsRemoveCompactionThresholdNamespace) (nonPersistentTopicsRemoveCompactionThresholdTopic) (nonPersistentTopicsRemoveCompactionThresholdIsGlobal) (nonPersistentTopicsRemoveCompactionThresholdAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveDeduplicationAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveDeduplicationParameters = NonPersistentTopicsRemoveDeduplicationParameters
  { nonPersistentTopicsRemoveDeduplicationTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveDeduplicationNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveDeduplicationTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveDeduplicationIsGlobal :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsRemoveDeduplicationAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveDeduplication :: NonPersistentTopicsRemoveDeduplicationParameters -> ClientM NoContent
nonPersistentTopicsRemoveDeduplication NonPersistentTopicsRemoveDeduplicationParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveDeduplicationAPI) (nonPersistentTopicsRemoveDeduplicationTenant) (nonPersistentTopicsRemoveDeduplicationNamespace) (nonPersistentTopicsRemoveDeduplicationTopic) (nonPersistentTopicsRemoveDeduplicationIsGlobal) (nonPersistentTopicsRemoveDeduplicationAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveDispatchRateParameters = NonPersistentTopicsRemoveDispatchRateParameters
  { nonPersistentTopicsRemoveDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveDispatchRate :: NonPersistentTopicsRemoveDispatchRateParameters -> ClientM NoContent
nonPersistentTopicsRemoveDispatchRate NonPersistentTopicsRemoveDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveDispatchRateAPI) (nonPersistentTopicsRemoveDispatchRateTenant) (nonPersistentTopicsRemoveDispatchRateNamespace) (nonPersistentTopicsRemoveDispatchRateTopic) (nonPersistentTopicsRemoveDispatchRateIsGlobal) (nonPersistentTopicsRemoveDispatchRateAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatcherPauseOnAckStatePersistent" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters = NonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters
  { nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistent :: NonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters -> ClientM NoContent
nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistent NonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentAPI) (nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentTenant) (nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentNamespace) (nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentTopic) (nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentIsGlobal) (nonPersistentTopicsRemoveDispatcherPauseOnAckStatePersistentAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveEntryFiltersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "entryFilters" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveEntryFiltersParameters = NonPersistentTopicsRemoveEntryFiltersParameters
  { nonPersistentTopicsRemoveEntryFiltersTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveEntryFiltersNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveEntryFiltersTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveEntryFiltersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveEntryFiltersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected thiscall to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveEntryFilters :: NonPersistentTopicsRemoveEntryFiltersParameters -> ClientM NoContent
nonPersistentTopicsRemoveEntryFilters NonPersistentTopicsRemoveEntryFiltersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveEntryFiltersAPI) (nonPersistentTopicsRemoveEntryFiltersTenant) (nonPersistentTopicsRemoveEntryFiltersNamespace) (nonPersistentTopicsRemoveEntryFiltersTopic) (nonPersistentTopicsRemoveEntryFiltersIsGlobal) (nonPersistentTopicsRemoveEntryFiltersAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveMaxConsumersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumers" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveMaxConsumersParameters = NonPersistentTopicsRemoveMaxConsumersParameters
  { nonPersistentTopicsRemoveMaxConsumersTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxConsumersNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxConsumersTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxConsumersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveMaxConsumersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveMaxConsumers :: NonPersistentTopicsRemoveMaxConsumersParameters -> ClientM NoContent
nonPersistentTopicsRemoveMaxConsumers NonPersistentTopicsRemoveMaxConsumersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveMaxConsumersAPI) (nonPersistentTopicsRemoveMaxConsumersTenant) (nonPersistentTopicsRemoveMaxConsumersNamespace) (nonPersistentTopicsRemoveMaxConsumersTopic) (nonPersistentTopicsRemoveMaxConsumersIsGlobal) (nonPersistentTopicsRemoveMaxConsumersAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveMaxConsumersPerSubscriptionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumersPerSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveMaxConsumersPerSubscriptionParameters = NonPersistentTopicsRemoveMaxConsumersPerSubscriptionParameters
  { nonPersistentTopicsRemoveMaxConsumersPerSubscriptionTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxConsumersPerSubscriptionNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxConsumersPerSubscriptionTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxConsumersPerSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveMaxConsumersPerSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveMaxConsumersPerSubscription :: NonPersistentTopicsRemoveMaxConsumersPerSubscriptionParameters -> ClientM NoContent
nonPersistentTopicsRemoveMaxConsumersPerSubscription NonPersistentTopicsRemoveMaxConsumersPerSubscriptionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveMaxConsumersPerSubscriptionAPI) (nonPersistentTopicsRemoveMaxConsumersPerSubscriptionTenant) (nonPersistentTopicsRemoveMaxConsumersPerSubscriptionNamespace) (nonPersistentTopicsRemoveMaxConsumersPerSubscriptionTopic) (nonPersistentTopicsRemoveMaxConsumersPerSubscriptionIsGlobal) (nonPersistentTopicsRemoveMaxConsumersPerSubscriptionAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveMaxMessageSizeAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxMessageSize" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveMaxMessageSizeParameters = NonPersistentTopicsRemoveMaxMessageSizeParameters
  { nonPersistentTopicsRemoveMaxMessageSizeTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxMessageSizeNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxMessageSizeTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxMessageSizeIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveMaxMessageSizeAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveMaxMessageSize :: NonPersistentTopicsRemoveMaxMessageSizeParameters -> ClientM NoContent
nonPersistentTopicsRemoveMaxMessageSize NonPersistentTopicsRemoveMaxMessageSizeParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveMaxMessageSizeAPI) (nonPersistentTopicsRemoveMaxMessageSizeTenant) (nonPersistentTopicsRemoveMaxMessageSizeNamespace) (nonPersistentTopicsRemoveMaxMessageSizeTopic) (nonPersistentTopicsRemoveMaxMessageSizeIsGlobal) (nonPersistentTopicsRemoveMaxMessageSizeAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveMaxProducersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxProducers" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveMaxProducersParameters = NonPersistentTopicsRemoveMaxProducersParameters
  { nonPersistentTopicsRemoveMaxProducersTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxProducersNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxProducersTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxProducersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveMaxProducersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveMaxProducers :: NonPersistentTopicsRemoveMaxProducersParameters -> ClientM NoContent
nonPersistentTopicsRemoveMaxProducers NonPersistentTopicsRemoveMaxProducersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveMaxProducersAPI) (nonPersistentTopicsRemoveMaxProducersTenant) (nonPersistentTopicsRemoveMaxProducersNamespace) (nonPersistentTopicsRemoveMaxProducersTopic) (nonPersistentTopicsRemoveMaxProducersIsGlobal) (nonPersistentTopicsRemoveMaxProducersAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveMaxSubscriptionsPerTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxSubscriptionsPerTopic" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveMaxSubscriptionsPerTopicParameters = NonPersistentTopicsRemoveMaxSubscriptionsPerTopicParameters
  { nonPersistentTopicsRemoveMaxSubscriptionsPerTopicTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxSubscriptionsPerTopicNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxSubscriptionsPerTopicTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveMaxSubscriptionsPerTopicIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveMaxSubscriptionsPerTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveMaxSubscriptionsPerTopic :: NonPersistentTopicsRemoveMaxSubscriptionsPerTopicParameters -> ClientM NoContent
nonPersistentTopicsRemoveMaxSubscriptionsPerTopic NonPersistentTopicsRemoveMaxSubscriptionsPerTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveMaxSubscriptionsPerTopicAPI) (nonPersistentTopicsRemoveMaxSubscriptionsPerTopicTenant) (nonPersistentTopicsRemoveMaxSubscriptionsPerTopicNamespace) (nonPersistentTopicsRemoveMaxSubscriptionsPerTopicTopic) (nonPersistentTopicsRemoveMaxSubscriptionsPerTopicIsGlobal) (nonPersistentTopicsRemoveMaxSubscriptionsPerTopicAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveMessageTTLAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "messageTTL" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveMessageTTLParameters = NonPersistentTopicsRemoveMessageTTLParameters
  { nonPersistentTopicsRemoveMessageTTLTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveMessageTTLNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveMessageTTLTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveMessageTTLIsGlobal :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsRemoveMessageTTLAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveMessageTTL :: NonPersistentTopicsRemoveMessageTTLParameters -> ClientM NoContent
nonPersistentTopicsRemoveMessageTTL NonPersistentTopicsRemoveMessageTTLParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveMessageTTLAPI) (nonPersistentTopicsRemoveMessageTTLTenant) (nonPersistentTopicsRemoveMessageTTLNamespace) (nonPersistentTopicsRemoveMessageTTLTopic) (nonPersistentTopicsRemoveMessageTTLIsGlobal) (nonPersistentTopicsRemoveMessageTTLAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveOffloadPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offloadPolicies" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveOffloadPoliciesParameters = NonPersistentTopicsRemoveOffloadPoliciesParameters
  { nonPersistentTopicsRemoveOffloadPoliciesTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveOffloadPoliciesNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveOffloadPoliciesTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveOffloadPoliciesIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveOffloadPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveOffloadPolicies :: NonPersistentTopicsRemoveOffloadPoliciesParameters -> ClientM NoContent
nonPersistentTopicsRemoveOffloadPolicies NonPersistentTopicsRemoveOffloadPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveOffloadPoliciesAPI) (nonPersistentTopicsRemoveOffloadPoliciesTenant) (nonPersistentTopicsRemoveOffloadPoliciesNamespace) (nonPersistentTopicsRemoveOffloadPoliciesTopic) (nonPersistentTopicsRemoveOffloadPoliciesIsGlobal) (nonPersistentTopicsRemoveOffloadPoliciesAuthoritative)

-- ^ 
type NonPersistentTopicsRemovePersistenceAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "persistence" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemovePersistenceParameters = NonPersistentTopicsRemovePersistenceParameters
  { nonPersistentTopicsRemovePersistenceTenant :: Text -- ^ 
  , nonPersistentTopicsRemovePersistenceNamespace :: Text -- ^ 
  , nonPersistentTopicsRemovePersistenceTopic :: Text -- ^ 
  , nonPersistentTopicsRemovePersistenceIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemovePersistenceAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemovePersistence :: NonPersistentTopicsRemovePersistenceParameters -> ClientM NoContent
nonPersistentTopicsRemovePersistence NonPersistentTopicsRemovePersistenceParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemovePersistenceAPI) (nonPersistentTopicsRemovePersistenceTenant) (nonPersistentTopicsRemovePersistenceNamespace) (nonPersistentTopicsRemovePersistenceTopic) (nonPersistentTopicsRemovePersistenceIsGlobal) (nonPersistentTopicsRemovePersistenceAuthoritative)

-- ^ 
type NonPersistentTopicsRemovePropertiesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "properties" :> QueryParam "key" Text :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemovePropertiesParameters = NonPersistentTopicsRemovePropertiesParameters
  { nonPersistentTopicsRemovePropertiesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsRemovePropertiesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsRemovePropertiesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsRemovePropertiesKey :: Maybe Text -- ^ 
  , nonPersistentTopicsRemovePropertiesAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveProperties :: NonPersistentTopicsRemovePropertiesParameters -> ClientM NoContent
nonPersistentTopicsRemoveProperties NonPersistentTopicsRemovePropertiesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemovePropertiesAPI) (nonPersistentTopicsRemovePropertiesTenant) (nonPersistentTopicsRemovePropertiesNamespace) (nonPersistentTopicsRemovePropertiesTopic) (nonPersistentTopicsRemovePropertiesKey) (nonPersistentTopicsRemovePropertiesAuthoritative)

-- ^ 
type NonPersistentTopicsRemovePublishRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "publishRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemovePublishRateParameters = NonPersistentTopicsRemovePublishRateParameters
  { nonPersistentTopicsRemovePublishRateTenant :: Text -- ^ 
  , nonPersistentTopicsRemovePublishRateNamespace :: Text -- ^ 
  , nonPersistentTopicsRemovePublishRateTopic :: Text -- ^ 
  , nonPersistentTopicsRemovePublishRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemovePublishRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemovePublishRate :: NonPersistentTopicsRemovePublishRateParameters -> ClientM NoContent
nonPersistentTopicsRemovePublishRate NonPersistentTopicsRemovePublishRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemovePublishRateAPI) (nonPersistentTopicsRemovePublishRateTenant) (nonPersistentTopicsRemovePublishRateNamespace) (nonPersistentTopicsRemovePublishRateTopic) (nonPersistentTopicsRemovePublishRateIsGlobal) (nonPersistentTopicsRemovePublishRateAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveReplicationClustersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replication" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveReplicationClustersParameters = NonPersistentTopicsRemoveReplicationClustersParameters
  { nonPersistentTopicsRemoveReplicationClustersTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveReplicationClustersNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveReplicationClustersTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveReplicationClustersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveReplicationClustersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveReplicationClusters :: NonPersistentTopicsRemoveReplicationClustersParameters -> ClientM NoContent
nonPersistentTopicsRemoveReplicationClusters NonPersistentTopicsRemoveReplicationClustersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveReplicationClustersAPI) (nonPersistentTopicsRemoveReplicationClustersTenant) (nonPersistentTopicsRemoveReplicationClustersNamespace) (nonPersistentTopicsRemoveReplicationClustersTopic) (nonPersistentTopicsRemoveReplicationClustersIsGlobal) (nonPersistentTopicsRemoveReplicationClustersAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveReplicatorDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replicatorDispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveReplicatorDispatchRateParameters = NonPersistentTopicsRemoveReplicatorDispatchRateParameters
  { nonPersistentTopicsRemoveReplicatorDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveReplicatorDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveReplicatorDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveReplicatorDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveReplicatorDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveReplicatorDispatchRate :: NonPersistentTopicsRemoveReplicatorDispatchRateParameters -> ClientM NoContent
nonPersistentTopicsRemoveReplicatorDispatchRate NonPersistentTopicsRemoveReplicatorDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveReplicatorDispatchRateAPI) (nonPersistentTopicsRemoveReplicatorDispatchRateTenant) (nonPersistentTopicsRemoveReplicatorDispatchRateNamespace) (nonPersistentTopicsRemoveReplicatorDispatchRateTopic) (nonPersistentTopicsRemoveReplicatorDispatchRateIsGlobal) (nonPersistentTopicsRemoveReplicatorDispatchRateAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveRetentionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "retention" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveRetentionParameters = NonPersistentTopicsRemoveRetentionParameters
  { nonPersistentTopicsRemoveRetentionTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveRetentionNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveRetentionTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveRetentionIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveRetentionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveRetention :: NonPersistentTopicsRemoveRetentionParameters -> ClientM NoContent
nonPersistentTopicsRemoveRetention NonPersistentTopicsRemoveRetentionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveRetentionAPI) (nonPersistentTopicsRemoveRetentionTenant) (nonPersistentTopicsRemoveRetentionNamespace) (nonPersistentTopicsRemoveRetentionTopic) (nonPersistentTopicsRemoveRetentionIsGlobal) (nonPersistentTopicsRemoveRetentionAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveSchemaCompatibilityStrategyAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaCompatibilityStrategy" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Text :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveSchemaCompatibilityStrategyParameters = NonPersistentTopicsRemoveSchemaCompatibilityStrategyParameters
  { nonPersistentTopicsRemoveSchemaCompatibilityStrategyTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsRemoveSchemaCompatibilityStrategyNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsRemoveSchemaCompatibilityStrategyTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsRemoveSchemaCompatibilityStrategyAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsRemoveSchemaCompatibilityStrategyBody :: Text -- ^ Strategy used to check the compatibility of new schema
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveSchemaCompatibilityStrategy :: NonPersistentTopicsRemoveSchemaCompatibilityStrategyParameters -> ClientM NoContent
nonPersistentTopicsRemoveSchemaCompatibilityStrategy NonPersistentTopicsRemoveSchemaCompatibilityStrategyParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveSchemaCompatibilityStrategyAPI) (nonPersistentTopicsRemoveSchemaCompatibilityStrategyTenant) (nonPersistentTopicsRemoveSchemaCompatibilityStrategyNamespace) (nonPersistentTopicsRemoveSchemaCompatibilityStrategyTopic) (nonPersistentTopicsRemoveSchemaCompatibilityStrategyAuthoritative) nonPersistentTopicsRemoveSchemaCompatibilityStrategyBody

-- ^ 
type NonPersistentTopicsRemoveSubscribeRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscribeRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] SubscribeRate :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveSubscribeRateParameters = NonPersistentTopicsRemoveSubscribeRateParameters
  { nonPersistentTopicsRemoveSubscribeRateTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscribeRateNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscribeRateTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscribeRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveSubscribeRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsRemoveSubscribeRateBody :: SubscribeRate -- ^ Subscribe rate for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveSubscribeRate :: NonPersistentTopicsRemoveSubscribeRateParameters -> ClientM NoContent
nonPersistentTopicsRemoveSubscribeRate NonPersistentTopicsRemoveSubscribeRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveSubscribeRateAPI) (nonPersistentTopicsRemoveSubscribeRateTenant) (nonPersistentTopicsRemoveSubscribeRateNamespace) (nonPersistentTopicsRemoveSubscribeRateTopic) (nonPersistentTopicsRemoveSubscribeRateIsGlobal) (nonPersistentTopicsRemoveSubscribeRateAuthoritative) nonPersistentTopicsRemoveSubscribeRateBody

-- ^ 
type NonPersistentTopicsRemoveSubscriptionDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionDispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveSubscriptionDispatchRateParameters = NonPersistentTopicsRemoveSubscriptionDispatchRateParameters
  { nonPersistentTopicsRemoveSubscriptionDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveSubscriptionDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveSubscriptionDispatchRate :: NonPersistentTopicsRemoveSubscriptionDispatchRateParameters -> ClientM NoContent
nonPersistentTopicsRemoveSubscriptionDispatchRate NonPersistentTopicsRemoveSubscriptionDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveSubscriptionDispatchRateAPI) (nonPersistentTopicsRemoveSubscriptionDispatchRateTenant) (nonPersistentTopicsRemoveSubscriptionDispatchRateNamespace) (nonPersistentTopicsRemoveSubscriptionDispatchRateTopic) (nonPersistentTopicsRemoveSubscriptionDispatchRateIsGlobal) (nonPersistentTopicsRemoveSubscriptionDispatchRateAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveSubscriptionLevelDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> Capture "subName" Text :> "dispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveSubscriptionLevelDispatchRateParameters = NonPersistentTopicsRemoveSubscriptionLevelDispatchRateParameters
  { nonPersistentTopicsRemoveSubscriptionLevelDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionLevelDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionLevelDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionLevelDispatchRateSubName :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionLevelDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveSubscriptionLevelDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveSubscriptionLevelDispatchRate :: NonPersistentTopicsRemoveSubscriptionLevelDispatchRateParameters -> ClientM NoContent
nonPersistentTopicsRemoveSubscriptionLevelDispatchRate NonPersistentTopicsRemoveSubscriptionLevelDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveSubscriptionLevelDispatchRateAPI) (nonPersistentTopicsRemoveSubscriptionLevelDispatchRateTenant) (nonPersistentTopicsRemoveSubscriptionLevelDispatchRateNamespace) (nonPersistentTopicsRemoveSubscriptionLevelDispatchRateTopic) (nonPersistentTopicsRemoveSubscriptionLevelDispatchRateSubName) (nonPersistentTopicsRemoveSubscriptionLevelDispatchRateIsGlobal) (nonPersistentTopicsRemoveSubscriptionLevelDispatchRateAuthoritative)

-- ^ 
type NonPersistentTopicsRemoveSubscriptionTypesEnabledAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionTypesEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRemoveSubscriptionTypesEnabledParameters = NonPersistentTopicsRemoveSubscriptionTypesEnabledParameters
  { nonPersistentTopicsRemoveSubscriptionTypesEnabledTenant :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionTypesEnabledNamespace :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionTypesEnabledTopic :: Text -- ^ 
  , nonPersistentTopicsRemoveSubscriptionTypesEnabledIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsRemoveSubscriptionTypesEnabledAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRemoveSubscriptionTypesEnabled :: NonPersistentTopicsRemoveSubscriptionTypesEnabledParameters -> ClientM NoContent
nonPersistentTopicsRemoveSubscriptionTypesEnabled NonPersistentTopicsRemoveSubscriptionTypesEnabledParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRemoveSubscriptionTypesEnabledAPI) (nonPersistentTopicsRemoveSubscriptionTypesEnabledTenant) (nonPersistentTopicsRemoveSubscriptionTypesEnabledNamespace) (nonPersistentTopicsRemoveSubscriptionTypesEnabledTopic) (nonPersistentTopicsRemoveSubscriptionTypesEnabledIsGlobal) (nonPersistentTopicsRemoveSubscriptionTypesEnabledAuthoritative)

-- ^ It fence cursor and disconnects all active consumers before resetting cursor.
type NonPersistentTopicsResetCursorAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "resetcursor" :> Capture "timestamp" Integer :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsResetCursorParameters = NonPersistentTopicsResetCursorParameters
  { nonPersistentTopicsResetCursorTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsResetCursorNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsResetCursorTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsResetCursorSubName :: Text -- ^ Subscription to reset position on
  , nonPersistentTopicsResetCursorTimestamp :: Integer -- ^ the timestamp to reset back
  , nonPersistentTopicsResetCursorAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsResetCursor :: NonPersistentTopicsResetCursorParameters -> ClientM NoContent
nonPersistentTopicsResetCursor NonPersistentTopicsResetCursorParameters {..} = client (Proxy :: Proxy NonPersistentTopicsResetCursorAPI) (nonPersistentTopicsResetCursorTenant) (nonPersistentTopicsResetCursorNamespace) (nonPersistentTopicsResetCursorTopic) (nonPersistentTopicsResetCursorSubName) (nonPersistentTopicsResetCursorTimestamp) (nonPersistentTopicsResetCursorAuthoritative)

-- ^ It fence cursor and disconnects all active consumers before resetting cursor.
type NonPersistentTopicsResetCursorOnPositionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "resetcursor" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] ResetCursorData :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsResetCursorOnPositionParameters = NonPersistentTopicsResetCursorOnPositionParameters
  { nonPersistentTopicsResetCursorOnPositionTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsResetCursorOnPositionNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsResetCursorOnPositionTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsResetCursorOnPositionSubName :: Text -- ^ Subscription to reset position on
  , nonPersistentTopicsResetCursorOnPositionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsResetCursorOnPositionMessageId :: ResetCursorData -- ^ messageId to reset back to (ledgerId:entryId)
  } deriving (Show, Eq, Generic)

nonPersistentTopicsResetCursorOnPosition :: NonPersistentTopicsResetCursorOnPositionParameters -> ClientM NoContent
nonPersistentTopicsResetCursorOnPosition NonPersistentTopicsResetCursorOnPositionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsResetCursorOnPositionAPI) (nonPersistentTopicsResetCursorOnPositionTenant) (nonPersistentTopicsResetCursorOnPositionNamespace) (nonPersistentTopicsResetCursorOnPositionTopic) (nonPersistentTopicsResetCursorOnPositionSubName) (nonPersistentTopicsResetCursorOnPositionAuthoritative) nonPersistentTopicsResetCursorOnPositionMessageId

-- ^ Revoke permissions to a role on a single topic. If the permission was not set at the topiclevel, but rather at the namespace level, this operation will return an error (HTTP status code 412).
type NonPersistentTopicsRevokePermissionsOnTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "permissions" :> Capture "role" Text :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsRevokePermissionsOnTopicParameters = NonPersistentTopicsRevokePermissionsOnTopicParameters
  { nonPersistentTopicsRevokePermissionsOnTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsRevokePermissionsOnTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsRevokePermissionsOnTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsRevokePermissionsOnTopicRole :: Text -- ^ Client role to which grant permissions
  } deriving (Show, Eq, Generic)

nonPersistentTopicsRevokePermissionsOnTopic :: NonPersistentTopicsRevokePermissionsOnTopicParameters -> ClientM NoContent
nonPersistentTopicsRevokePermissionsOnTopic NonPersistentTopicsRevokePermissionsOnTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsRevokePermissionsOnTopicAPI) (nonPersistentTopicsRevokePermissionsOnTopicTenant) (nonPersistentTopicsRevokePermissionsOnTopicNamespace) (nonPersistentTopicsRevokePermissionsOnTopicTopic) (nonPersistentTopicsRevokePermissionsOnTopicRole)

-- ^ 
type NonPersistentTopicsSetAutoSubscriptionCreationAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "autoSubscriptionCreation" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] AutoSubscriptionCreationOverrideImpl :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetAutoSubscriptionCreationParameters = NonPersistentTopicsSetAutoSubscriptionCreationParameters
  { nonPersistentTopicsSetAutoSubscriptionCreationTenant :: Text -- ^ 
  , nonPersistentTopicsSetAutoSubscriptionCreationNamespace :: Text -- ^ 
  , nonPersistentTopicsSetAutoSubscriptionCreationTopic :: Text -- ^ 
  , nonPersistentTopicsSetAutoSubscriptionCreationIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetAutoSubscriptionCreationAuthoritative :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetAutoSubscriptionCreationBody :: AutoSubscriptionCreationOverrideImpl -- ^ Settings for automatic subscription creation
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetAutoSubscriptionCreation :: NonPersistentTopicsSetAutoSubscriptionCreationParameters -> ClientM NoContent
nonPersistentTopicsSetAutoSubscriptionCreation NonPersistentTopicsSetAutoSubscriptionCreationParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetAutoSubscriptionCreationAPI) (nonPersistentTopicsSetAutoSubscriptionCreationTenant) (nonPersistentTopicsSetAutoSubscriptionCreationNamespace) (nonPersistentTopicsSetAutoSubscriptionCreationTopic) (nonPersistentTopicsSetAutoSubscriptionCreationIsGlobal) (nonPersistentTopicsSetAutoSubscriptionCreationAuthoritative) nonPersistentTopicsSetAutoSubscriptionCreationBody

-- ^ 
type NonPersistentTopicsSetBacklogQuotaAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlogQuota" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> QueryParam "backlogQuotaType" Text :> ReqBody '[JSON] BacklogQuotaImpl :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetBacklogQuotaParameters = NonPersistentTopicsSetBacklogQuotaParameters
  { nonPersistentTopicsSetBacklogQuotaTenant :: Text -- ^ 
  , nonPersistentTopicsSetBacklogQuotaNamespace :: Text -- ^ 
  , nonPersistentTopicsSetBacklogQuotaTopic :: Text -- ^ 
  , nonPersistentTopicsSetBacklogQuotaAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetBacklogQuotaIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetBacklogQuotaBacklogQuotaType :: Maybe Text -- ^ 
  , nonPersistentTopicsSetBacklogQuotaBody :: BacklogQuotaImpl -- ^ backlog quota policies for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetBacklogQuota :: NonPersistentTopicsSetBacklogQuotaParameters -> ClientM NoContent
nonPersistentTopicsSetBacklogQuota NonPersistentTopicsSetBacklogQuotaParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetBacklogQuotaAPI) (nonPersistentTopicsSetBacklogQuotaTenant) (nonPersistentTopicsSetBacklogQuotaNamespace) (nonPersistentTopicsSetBacklogQuotaTopic) (nonPersistentTopicsSetBacklogQuotaAuthoritative) (nonPersistentTopicsSetBacklogQuotaIsGlobal) (nonPersistentTopicsSetBacklogQuotaBacklogQuotaType) nonPersistentTopicsSetBacklogQuotaBody

-- ^ 
type NonPersistentTopicsSetCompactionThresholdAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compactionThreshold" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] Integer :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetCompactionThresholdParameters = NonPersistentTopicsSetCompactionThresholdParameters
  { nonPersistentTopicsSetCompactionThresholdTenant :: Text -- ^ 
  , nonPersistentTopicsSetCompactionThresholdNamespace :: Text -- ^ 
  , nonPersistentTopicsSetCompactionThresholdTopic :: Text -- ^ 
  , nonPersistentTopicsSetCompactionThresholdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetCompactionThresholdIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetCompactionThresholdBody :: Integer -- ^ Dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetCompactionThreshold :: NonPersistentTopicsSetCompactionThresholdParameters -> ClientM NoContent
nonPersistentTopicsSetCompactionThreshold NonPersistentTopicsSetCompactionThresholdParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetCompactionThresholdAPI) (nonPersistentTopicsSetCompactionThresholdTenant) (nonPersistentTopicsSetCompactionThresholdNamespace) (nonPersistentTopicsSetCompactionThresholdTopic) (nonPersistentTopicsSetCompactionThresholdAuthoritative) (nonPersistentTopicsSetCompactionThresholdIsGlobal) nonPersistentTopicsSetCompactionThresholdBody

-- ^ 
type NonPersistentTopicsSetDeduplicationAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetDeduplicationParameters = NonPersistentTopicsSetDeduplicationParameters
  { nonPersistentTopicsSetDeduplicationTenant :: Text -- ^ 
  , nonPersistentTopicsSetDeduplicationNamespace :: Text -- ^ 
  , nonPersistentTopicsSetDeduplicationTopic :: Text -- ^ 
  , nonPersistentTopicsSetDeduplicationIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetDeduplicationAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetDeduplicationBody :: Bool -- ^ DeduplicationEnabled policies for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetDeduplication :: NonPersistentTopicsSetDeduplicationParameters -> ClientM NoContent
nonPersistentTopicsSetDeduplication NonPersistentTopicsSetDeduplicationParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetDeduplicationAPI) (nonPersistentTopicsSetDeduplicationTenant) (nonPersistentTopicsSetDeduplicationNamespace) (nonPersistentTopicsSetDeduplicationTopic) (nonPersistentTopicsSetDeduplicationIsGlobal) (nonPersistentTopicsSetDeduplicationAuthoritative) nonPersistentTopicsSetDeduplicationBody

-- ^ 
type NonPersistentTopicsSetDeduplicationSnapshotIntervalAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationSnapshotInterval" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetDeduplicationSnapshotIntervalParameters = NonPersistentTopicsSetDeduplicationSnapshotIntervalParameters
  { nonPersistentTopicsSetDeduplicationSnapshotIntervalTenant :: Text -- ^ 
  , nonPersistentTopicsSetDeduplicationSnapshotIntervalNamespace :: Text -- ^ 
  , nonPersistentTopicsSetDeduplicationSnapshotIntervalTopic :: Text -- ^ 
  , nonPersistentTopicsSetDeduplicationSnapshotIntervalIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetDeduplicationSnapshotIntervalAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetDeduplicationSnapshotIntervalBody :: Int -- ^ Interval to take deduplication snapshot for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetDeduplicationSnapshotInterval :: NonPersistentTopicsSetDeduplicationSnapshotIntervalParameters -> ClientM NoContent
nonPersistentTopicsSetDeduplicationSnapshotInterval NonPersistentTopicsSetDeduplicationSnapshotIntervalParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetDeduplicationSnapshotIntervalAPI) (nonPersistentTopicsSetDeduplicationSnapshotIntervalTenant) (nonPersistentTopicsSetDeduplicationSnapshotIntervalNamespace) (nonPersistentTopicsSetDeduplicationSnapshotIntervalTopic) (nonPersistentTopicsSetDeduplicationSnapshotIntervalIsGlobal) (nonPersistentTopicsSetDeduplicationSnapshotIntervalAuthoritative) nonPersistentTopicsSetDeduplicationSnapshotIntervalBody

-- ^ 
type NonPersistentTopicsSetDelayedDeliveryPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "delayedDelivery" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] DelayedDeliveryPolicies :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetDelayedDeliveryPoliciesParameters = NonPersistentTopicsSetDelayedDeliveryPoliciesParameters
  { nonPersistentTopicsSetDelayedDeliveryPoliciesTenant :: Text -- ^ 
  , nonPersistentTopicsSetDelayedDeliveryPoliciesNamespace :: Text -- ^ 
  , nonPersistentTopicsSetDelayedDeliveryPoliciesTopic :: Text -- ^ 
  , nonPersistentTopicsSetDelayedDeliveryPoliciesIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetDelayedDeliveryPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetDelayedDeliveryPoliciesBody :: DelayedDeliveryPolicies -- ^ Delayed delivery policies for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetDelayedDeliveryPolicies :: NonPersistentTopicsSetDelayedDeliveryPoliciesParameters -> ClientM NoContent
nonPersistentTopicsSetDelayedDeliveryPolicies NonPersistentTopicsSetDelayedDeliveryPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetDelayedDeliveryPoliciesAPI) (nonPersistentTopicsSetDelayedDeliveryPoliciesTenant) (nonPersistentTopicsSetDelayedDeliveryPoliciesNamespace) (nonPersistentTopicsSetDelayedDeliveryPoliciesTopic) (nonPersistentTopicsSetDelayedDeliveryPoliciesIsGlobal) (nonPersistentTopicsSetDelayedDeliveryPoliciesAuthoritative) nonPersistentTopicsSetDelayedDeliveryPoliciesBody

-- ^ 
type NonPersistentTopicsSetDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatchRate" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetDispatchRateParameters = NonPersistentTopicsSetDispatchRateParameters
  { nonPersistentTopicsSetDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsSetDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsSetDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsSetDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetDispatchRateBody :: DispatchRateImpl -- ^ Dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetDispatchRate :: NonPersistentTopicsSetDispatchRateParameters -> ClientM NoContent
nonPersistentTopicsSetDispatchRate NonPersistentTopicsSetDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetDispatchRateAPI) (nonPersistentTopicsSetDispatchRateTenant) (nonPersistentTopicsSetDispatchRateNamespace) (nonPersistentTopicsSetDispatchRateTopic) (nonPersistentTopicsSetDispatchRateAuthoritative) (nonPersistentTopicsSetDispatchRateIsGlobal) nonPersistentTopicsSetDispatchRateBody

-- ^ 
type NonPersistentTopicsSetDispatcherPauseOnAckStatePersistentAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatcherPauseOnAckStatePersistent" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters = NonPersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters
  { nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentTenant :: Text -- ^ 
  , nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentNamespace :: Text -- ^ 
  , nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentTopic :: Text -- ^ 
  , nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentIsGlobal :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetDispatcherPauseOnAckStatePersistent :: NonPersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters -> ClientM NoContent
nonPersistentTopicsSetDispatcherPauseOnAckStatePersistent NonPersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetDispatcherPauseOnAckStatePersistentAPI) (nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentTenant) (nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentNamespace) (nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentTopic) (nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentAuthoritative) (nonPersistentTopicsSetDispatcherPauseOnAckStatePersistentIsGlobal)

-- ^ 
type NonPersistentTopicsSetEntryFiltersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "entryFilters" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] EntryFilters :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetEntryFiltersParameters = NonPersistentTopicsSetEntryFiltersParameters
  { nonPersistentTopicsSetEntryFiltersTenant :: Text -- ^ 
  , nonPersistentTopicsSetEntryFiltersNamespace :: Text -- ^ 
  , nonPersistentTopicsSetEntryFiltersTopic :: Text -- ^ 
  , nonPersistentTopicsSetEntryFiltersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetEntryFiltersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetEntryFiltersBody :: EntryFilters -- ^ Enable sub types for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetEntryFilters :: NonPersistentTopicsSetEntryFiltersParameters -> ClientM NoContent
nonPersistentTopicsSetEntryFilters NonPersistentTopicsSetEntryFiltersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetEntryFiltersAPI) (nonPersistentTopicsSetEntryFiltersTenant) (nonPersistentTopicsSetEntryFiltersNamespace) (nonPersistentTopicsSetEntryFiltersTopic) (nonPersistentTopicsSetEntryFiltersIsGlobal) (nonPersistentTopicsSetEntryFiltersAuthoritative) nonPersistentTopicsSetEntryFiltersBody

-- ^ 
type NonPersistentTopicsSetInactiveTopicPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "inactiveTopicPolicies" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] InactiveTopicPolicies :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetInactiveTopicPoliciesParameters = NonPersistentTopicsSetInactiveTopicPoliciesParameters
  { nonPersistentTopicsSetInactiveTopicPoliciesTenant :: Text -- ^ 
  , nonPersistentTopicsSetInactiveTopicPoliciesNamespace :: Text -- ^ 
  , nonPersistentTopicsSetInactiveTopicPoliciesTopic :: Text -- ^ 
  , nonPersistentTopicsSetInactiveTopicPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetInactiveTopicPoliciesIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetInactiveTopicPoliciesBody :: InactiveTopicPolicies -- ^ inactive topic policies for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetInactiveTopicPolicies :: NonPersistentTopicsSetInactiveTopicPoliciesParameters -> ClientM NoContent
nonPersistentTopicsSetInactiveTopicPolicies NonPersistentTopicsSetInactiveTopicPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetInactiveTopicPoliciesAPI) (nonPersistentTopicsSetInactiveTopicPoliciesTenant) (nonPersistentTopicsSetInactiveTopicPoliciesNamespace) (nonPersistentTopicsSetInactiveTopicPoliciesTopic) (nonPersistentTopicsSetInactiveTopicPoliciesAuthoritative) (nonPersistentTopicsSetInactiveTopicPoliciesIsGlobal) nonPersistentTopicsSetInactiveTopicPoliciesBody

-- ^ 
type NonPersistentTopicsSetMaxConsumersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumers" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetMaxConsumersParameters = NonPersistentTopicsSetMaxConsumersParameters
  { nonPersistentTopicsSetMaxConsumersTenant :: Text -- ^ 
  , nonPersistentTopicsSetMaxConsumersNamespace :: Text -- ^ 
  , nonPersistentTopicsSetMaxConsumersTopic :: Text -- ^ 
  , nonPersistentTopicsSetMaxConsumersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetMaxConsumersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetMaxConsumersBody :: Int -- ^ The max consumers of the topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetMaxConsumers :: NonPersistentTopicsSetMaxConsumersParameters -> ClientM NoContent
nonPersistentTopicsSetMaxConsumers NonPersistentTopicsSetMaxConsumersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetMaxConsumersAPI) (nonPersistentTopicsSetMaxConsumersTenant) (nonPersistentTopicsSetMaxConsumersNamespace) (nonPersistentTopicsSetMaxConsumersTopic) (nonPersistentTopicsSetMaxConsumersIsGlobal) (nonPersistentTopicsSetMaxConsumersAuthoritative) nonPersistentTopicsSetMaxConsumersBody

-- ^ 
type NonPersistentTopicsSetMaxConsumersPerSubscriptionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumersPerSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetMaxConsumersPerSubscriptionParameters = NonPersistentTopicsSetMaxConsumersPerSubscriptionParameters
  { nonPersistentTopicsSetMaxConsumersPerSubscriptionTenant :: Text -- ^ 
  , nonPersistentTopicsSetMaxConsumersPerSubscriptionNamespace :: Text -- ^ 
  , nonPersistentTopicsSetMaxConsumersPerSubscriptionTopic :: Text -- ^ 
  , nonPersistentTopicsSetMaxConsumersPerSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetMaxConsumersPerSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetMaxConsumersPerSubscriptionBody :: Int -- ^ Dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetMaxConsumersPerSubscription :: NonPersistentTopicsSetMaxConsumersPerSubscriptionParameters -> ClientM NoContent
nonPersistentTopicsSetMaxConsumersPerSubscription NonPersistentTopicsSetMaxConsumersPerSubscriptionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetMaxConsumersPerSubscriptionAPI) (nonPersistentTopicsSetMaxConsumersPerSubscriptionTenant) (nonPersistentTopicsSetMaxConsumersPerSubscriptionNamespace) (nonPersistentTopicsSetMaxConsumersPerSubscriptionTopic) (nonPersistentTopicsSetMaxConsumersPerSubscriptionIsGlobal) (nonPersistentTopicsSetMaxConsumersPerSubscriptionAuthoritative) nonPersistentTopicsSetMaxConsumersPerSubscriptionBody

-- ^ 
type NonPersistentTopicsSetMaxMessageSizeAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxMessageSize" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetMaxMessageSizeParameters = NonPersistentTopicsSetMaxMessageSizeParameters
  { nonPersistentTopicsSetMaxMessageSizeTenant :: Text -- ^ 
  , nonPersistentTopicsSetMaxMessageSizeNamespace :: Text -- ^ 
  , nonPersistentTopicsSetMaxMessageSizeTopic :: Text -- ^ 
  , nonPersistentTopicsSetMaxMessageSizeIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetMaxMessageSizeAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetMaxMessageSizeBody :: Int -- ^ The max message size of the topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetMaxMessageSize :: NonPersistentTopicsSetMaxMessageSizeParameters -> ClientM NoContent
nonPersistentTopicsSetMaxMessageSize NonPersistentTopicsSetMaxMessageSizeParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetMaxMessageSizeAPI) (nonPersistentTopicsSetMaxMessageSizeTenant) (nonPersistentTopicsSetMaxMessageSizeNamespace) (nonPersistentTopicsSetMaxMessageSizeTopic) (nonPersistentTopicsSetMaxMessageSizeIsGlobal) (nonPersistentTopicsSetMaxMessageSizeAuthoritative) nonPersistentTopicsSetMaxMessageSizeBody

-- ^ 
type NonPersistentTopicsSetMaxProducersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxProducers" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetMaxProducersParameters = NonPersistentTopicsSetMaxProducersParameters
  { nonPersistentTopicsSetMaxProducersTenant :: Text -- ^ 
  , nonPersistentTopicsSetMaxProducersNamespace :: Text -- ^ 
  , nonPersistentTopicsSetMaxProducersTopic :: Text -- ^ 
  , nonPersistentTopicsSetMaxProducersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetMaxProducersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetMaxProducersBody :: Int -- ^ The max producers of the topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetMaxProducers :: NonPersistentTopicsSetMaxProducersParameters -> ClientM NoContent
nonPersistentTopicsSetMaxProducers NonPersistentTopicsSetMaxProducersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetMaxProducersAPI) (nonPersistentTopicsSetMaxProducersTenant) (nonPersistentTopicsSetMaxProducersNamespace) (nonPersistentTopicsSetMaxProducersTopic) (nonPersistentTopicsSetMaxProducersAuthoritative) (nonPersistentTopicsSetMaxProducersIsGlobal) nonPersistentTopicsSetMaxProducersBody

-- ^ 
type NonPersistentTopicsSetMaxSubscriptionsPerTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxSubscriptionsPerTopic" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetMaxSubscriptionsPerTopicParameters = NonPersistentTopicsSetMaxSubscriptionsPerTopicParameters
  { nonPersistentTopicsSetMaxSubscriptionsPerTopicTenant :: Text -- ^ 
  , nonPersistentTopicsSetMaxSubscriptionsPerTopicNamespace :: Text -- ^ 
  , nonPersistentTopicsSetMaxSubscriptionsPerTopicTopic :: Text -- ^ 
  , nonPersistentTopicsSetMaxSubscriptionsPerTopicIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetMaxSubscriptionsPerTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetMaxSubscriptionsPerTopicBody :: Int -- ^ The max subscriptions of the topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetMaxSubscriptionsPerTopic :: NonPersistentTopicsSetMaxSubscriptionsPerTopicParameters -> ClientM NoContent
nonPersistentTopicsSetMaxSubscriptionsPerTopic NonPersistentTopicsSetMaxSubscriptionsPerTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetMaxSubscriptionsPerTopicAPI) (nonPersistentTopicsSetMaxSubscriptionsPerTopicTenant) (nonPersistentTopicsSetMaxSubscriptionsPerTopicNamespace) (nonPersistentTopicsSetMaxSubscriptionsPerTopicTopic) (nonPersistentTopicsSetMaxSubscriptionsPerTopicIsGlobal) (nonPersistentTopicsSetMaxSubscriptionsPerTopicAuthoritative) nonPersistentTopicsSetMaxSubscriptionsPerTopicBody

-- ^ 
type NonPersistentTopicsSetMaxUnackedMessagesOnConsumerAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnConsumer" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetMaxUnackedMessagesOnConsumerParameters = NonPersistentTopicsSetMaxUnackedMessagesOnConsumerParameters
  { nonPersistentTopicsSetMaxUnackedMessagesOnConsumerTenant :: Text -- ^ 
  , nonPersistentTopicsSetMaxUnackedMessagesOnConsumerNamespace :: Text -- ^ 
  , nonPersistentTopicsSetMaxUnackedMessagesOnConsumerTopic :: Text -- ^ 
  , nonPersistentTopicsSetMaxUnackedMessagesOnConsumerIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetMaxUnackedMessagesOnConsumerAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetMaxUnackedMessagesOnConsumerBody :: Int -- ^ Max unacked messages on consumer policies for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetMaxUnackedMessagesOnConsumer :: NonPersistentTopicsSetMaxUnackedMessagesOnConsumerParameters -> ClientM NoContent
nonPersistentTopicsSetMaxUnackedMessagesOnConsumer NonPersistentTopicsSetMaxUnackedMessagesOnConsumerParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetMaxUnackedMessagesOnConsumerAPI) (nonPersistentTopicsSetMaxUnackedMessagesOnConsumerTenant) (nonPersistentTopicsSetMaxUnackedMessagesOnConsumerNamespace) (nonPersistentTopicsSetMaxUnackedMessagesOnConsumerTopic) (nonPersistentTopicsSetMaxUnackedMessagesOnConsumerIsGlobal) (nonPersistentTopicsSetMaxUnackedMessagesOnConsumerAuthoritative) nonPersistentTopicsSetMaxUnackedMessagesOnConsumerBody

-- ^ 
type NonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters = NonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters
  { nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionTenant :: Text -- ^ 
  , nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionNamespace :: Text -- ^ 
  , nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionTopic :: Text -- ^ 
  , nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionBody :: Int -- ^ Max unacked messages on subscription policies for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetMaxUnackedMessagesOnSubscription :: NonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters -> ClientM NoContent
nonPersistentTopicsSetMaxUnackedMessagesOnSubscription NonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionAPI) (nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionTenant) (nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionNamespace) (nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionTopic) (nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionIsGlobal) (nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionAuthoritative) nonPersistentTopicsSetMaxUnackedMessagesOnSubscriptionBody

-- ^ 
type NonPersistentTopicsSetMessageTTLAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "messageTTL" :> QueryParam "messageTTL" Int :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetMessageTTLParameters = NonPersistentTopicsSetMessageTTLParameters
  { nonPersistentTopicsSetMessageTTLTenant :: Text -- ^ 
  , nonPersistentTopicsSetMessageTTLNamespace :: Text -- ^ 
  , nonPersistentTopicsSetMessageTTLTopic :: Text -- ^ 
  , nonPersistentTopicsSetMessageTTLMessageTTL :: Int -- ^ TTL in seconds for the specified topic
  , nonPersistentTopicsSetMessageTTLIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetMessageTTLAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetMessageTTL :: NonPersistentTopicsSetMessageTTLParameters -> ClientM NoContent
nonPersistentTopicsSetMessageTTL NonPersistentTopicsSetMessageTTLParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetMessageTTLAPI) (nonPersistentTopicsSetMessageTTLTenant) (nonPersistentTopicsSetMessageTTLNamespace) (nonPersistentTopicsSetMessageTTLTopic) (Just nonPersistentTopicsSetMessageTTLMessageTTL) (nonPersistentTopicsSetMessageTTLIsGlobal) (nonPersistentTopicsSetMessageTTLAuthoritative)

-- ^ 
type NonPersistentTopicsSetOffloadPoliciesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offloadPolicies" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] OffloadPoliciesImpl :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetOffloadPoliciesParameters = NonPersistentTopicsSetOffloadPoliciesParameters
  { nonPersistentTopicsSetOffloadPoliciesTenant :: Text -- ^ 
  , nonPersistentTopicsSetOffloadPoliciesNamespace :: Text -- ^ 
  , nonPersistentTopicsSetOffloadPoliciesTopic :: Text -- ^ 
  , nonPersistentTopicsSetOffloadPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetOffloadPoliciesIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetOffloadPoliciesBody :: OffloadPoliciesImpl -- ^ Offload policies for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetOffloadPolicies :: NonPersistentTopicsSetOffloadPoliciesParameters -> ClientM NoContent
nonPersistentTopicsSetOffloadPolicies NonPersistentTopicsSetOffloadPoliciesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetOffloadPoliciesAPI) (nonPersistentTopicsSetOffloadPoliciesTenant) (nonPersistentTopicsSetOffloadPoliciesNamespace) (nonPersistentTopicsSetOffloadPoliciesTopic) (nonPersistentTopicsSetOffloadPoliciesAuthoritative) (nonPersistentTopicsSetOffloadPoliciesIsGlobal) nonPersistentTopicsSetOffloadPoliciesBody

-- ^ 
type NonPersistentTopicsSetPersistenceAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "persistence" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] PersistencePolicies :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetPersistenceParameters = NonPersistentTopicsSetPersistenceParameters
  { nonPersistentTopicsSetPersistenceTenant :: Text -- ^ 
  , nonPersistentTopicsSetPersistenceNamespace :: Text -- ^ 
  , nonPersistentTopicsSetPersistenceTopic :: Text -- ^ 
  , nonPersistentTopicsSetPersistenceAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetPersistenceIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetPersistenceBody :: PersistencePolicies -- ^ Bookkeeper persistence policies for specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetPersistence :: NonPersistentTopicsSetPersistenceParameters -> ClientM NoContent
nonPersistentTopicsSetPersistence NonPersistentTopicsSetPersistenceParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetPersistenceAPI) (nonPersistentTopicsSetPersistenceTenant) (nonPersistentTopicsSetPersistenceNamespace) (nonPersistentTopicsSetPersistenceTopic) (nonPersistentTopicsSetPersistenceAuthoritative) (nonPersistentTopicsSetPersistenceIsGlobal) nonPersistentTopicsSetPersistenceBody

-- ^ 
type NonPersistentTopicsSetPublishRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "publishRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] PublishRate :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetPublishRateParameters = NonPersistentTopicsSetPublishRateParameters
  { nonPersistentTopicsSetPublishRateTenant :: Text -- ^ 
  , nonPersistentTopicsSetPublishRateNamespace :: Text -- ^ 
  , nonPersistentTopicsSetPublishRateTopic :: Text -- ^ 
  , nonPersistentTopicsSetPublishRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetPublishRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetPublishRateBody :: PublishRate -- ^ Dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetPublishRate :: NonPersistentTopicsSetPublishRateParameters -> ClientM NoContent
nonPersistentTopicsSetPublishRate NonPersistentTopicsSetPublishRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetPublishRateAPI) (nonPersistentTopicsSetPublishRateTenant) (nonPersistentTopicsSetPublishRateNamespace) (nonPersistentTopicsSetPublishRateTopic) (nonPersistentTopicsSetPublishRateIsGlobal) (nonPersistentTopicsSetPublishRateAuthoritative) nonPersistentTopicsSetPublishRateBody

-- ^ 
type NonPersistentTopicsSetReplicatedSubscriptionStatusAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "replicatedSubscriptionStatus" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetReplicatedSubscriptionStatusParameters = NonPersistentTopicsSetReplicatedSubscriptionStatusParameters
  { nonPersistentTopicsSetReplicatedSubscriptionStatusTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsSetReplicatedSubscriptionStatusNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsSetReplicatedSubscriptionStatusTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsSetReplicatedSubscriptionStatusSubName :: Text -- ^ Name of subscription
  , nonPersistentTopicsSetReplicatedSubscriptionStatusBody :: Bool -- ^ Whether to enable replicated subscription
  , nonPersistentTopicsSetReplicatedSubscriptionStatusAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetReplicatedSubscriptionStatus :: NonPersistentTopicsSetReplicatedSubscriptionStatusParameters -> ClientM NoContent
nonPersistentTopicsSetReplicatedSubscriptionStatus NonPersistentTopicsSetReplicatedSubscriptionStatusParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetReplicatedSubscriptionStatusAPI) (nonPersistentTopicsSetReplicatedSubscriptionStatusTenant) (nonPersistentTopicsSetReplicatedSubscriptionStatusNamespace) (nonPersistentTopicsSetReplicatedSubscriptionStatusTopic) (nonPersistentTopicsSetReplicatedSubscriptionStatusSubName) (nonPersistentTopicsSetReplicatedSubscriptionStatusAuthoritative) nonPersistentTopicsSetReplicatedSubscriptionStatusBody

-- ^ 
type NonPersistentTopicsSetReplicationClustersAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replication" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetReplicationClustersParameters = NonPersistentTopicsSetReplicationClustersParameters
  { nonPersistentTopicsSetReplicationClustersTenant :: Text -- ^ 
  , nonPersistentTopicsSetReplicationClustersNamespace :: Text -- ^ 
  , nonPersistentTopicsSetReplicationClustersTopic :: Text -- ^ 
  , nonPersistentTopicsSetReplicationClustersBody :: [Text] -- ^ List of replication clusters
  , nonPersistentTopicsSetReplicationClustersIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetReplicationClustersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetReplicationClusters :: NonPersistentTopicsSetReplicationClustersParameters -> ClientM NoContent
nonPersistentTopicsSetReplicationClusters NonPersistentTopicsSetReplicationClustersParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetReplicationClustersAPI) (nonPersistentTopicsSetReplicationClustersTenant) (nonPersistentTopicsSetReplicationClustersNamespace) (nonPersistentTopicsSetReplicationClustersTopic) (nonPersistentTopicsSetReplicationClustersIsGlobal) (nonPersistentTopicsSetReplicationClustersAuthoritative) nonPersistentTopicsSetReplicationClustersBody

-- ^ 
type NonPersistentTopicsSetReplicatorDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replicatorDispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetReplicatorDispatchRateParameters = NonPersistentTopicsSetReplicatorDispatchRateParameters
  { nonPersistentTopicsSetReplicatorDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsSetReplicatorDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsSetReplicatorDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsSetReplicatorDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetReplicatorDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetReplicatorDispatchRateBody :: DispatchRateImpl -- ^ Replicator dispatch rate of the topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetReplicatorDispatchRate :: NonPersistentTopicsSetReplicatorDispatchRateParameters -> ClientM NoContent
nonPersistentTopicsSetReplicatorDispatchRate NonPersistentTopicsSetReplicatorDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetReplicatorDispatchRateAPI) (nonPersistentTopicsSetReplicatorDispatchRateTenant) (nonPersistentTopicsSetReplicatorDispatchRateNamespace) (nonPersistentTopicsSetReplicatorDispatchRateTopic) (nonPersistentTopicsSetReplicatorDispatchRateIsGlobal) (nonPersistentTopicsSetReplicatorDispatchRateAuthoritative) nonPersistentTopicsSetReplicatorDispatchRateBody

-- ^ 
type NonPersistentTopicsSetRetentionAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "retention" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] RetentionPolicies :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetRetentionParameters = NonPersistentTopicsSetRetentionParameters
  { nonPersistentTopicsSetRetentionTenant :: Text -- ^ 
  , nonPersistentTopicsSetRetentionNamespace :: Text -- ^ 
  , nonPersistentTopicsSetRetentionTopic :: Text -- ^ 
  , nonPersistentTopicsSetRetentionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetRetentionIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetRetentionBody :: RetentionPolicies -- ^ Retention policies for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetRetention :: NonPersistentTopicsSetRetentionParameters -> ClientM NoContent
nonPersistentTopicsSetRetention NonPersistentTopicsSetRetentionParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetRetentionAPI) (nonPersistentTopicsSetRetentionTenant) (nonPersistentTopicsSetRetentionNamespace) (nonPersistentTopicsSetRetentionTopic) (nonPersistentTopicsSetRetentionAuthoritative) (nonPersistentTopicsSetRetentionIsGlobal) nonPersistentTopicsSetRetentionBody

-- ^ 
type NonPersistentTopicsSetSchemaCompatibilityStrategyAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaCompatibilityStrategy" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Text :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsSetSchemaCompatibilityStrategyParameters = NonPersistentTopicsSetSchemaCompatibilityStrategyParameters
  { nonPersistentTopicsSetSchemaCompatibilityStrategyTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsSetSchemaCompatibilityStrategyNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsSetSchemaCompatibilityStrategyTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsSetSchemaCompatibilityStrategyAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetSchemaCompatibilityStrategyBody :: Text -- ^ Strategy used to check the compatibility of new schema
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetSchemaCompatibilityStrategy :: NonPersistentTopicsSetSchemaCompatibilityStrategyParameters -> ClientM NoContent
nonPersistentTopicsSetSchemaCompatibilityStrategy NonPersistentTopicsSetSchemaCompatibilityStrategyParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetSchemaCompatibilityStrategyAPI) (nonPersistentTopicsSetSchemaCompatibilityStrategyTenant) (nonPersistentTopicsSetSchemaCompatibilityStrategyNamespace) (nonPersistentTopicsSetSchemaCompatibilityStrategyTopic) (nonPersistentTopicsSetSchemaCompatibilityStrategyAuthoritative) nonPersistentTopicsSetSchemaCompatibilityStrategyBody

-- ^ 
type NonPersistentTopicsSetSchemaValidationEnforcedAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaValidationEnforced" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetSchemaValidationEnforcedParameters = NonPersistentTopicsSetSchemaValidationEnforcedParameters
  { nonPersistentTopicsSetSchemaValidationEnforcedTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsSetSchemaValidationEnforcedNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsSetSchemaValidationEnforcedTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsSetSchemaValidationEnforcedBody :: Bool -- ^ 
  , nonPersistentTopicsSetSchemaValidationEnforcedAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetSchemaValidationEnforced :: NonPersistentTopicsSetSchemaValidationEnforcedParameters -> ClientM NoContent
nonPersistentTopicsSetSchemaValidationEnforced NonPersistentTopicsSetSchemaValidationEnforcedParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetSchemaValidationEnforcedAPI) (nonPersistentTopicsSetSchemaValidationEnforcedTenant) (nonPersistentTopicsSetSchemaValidationEnforcedNamespace) (nonPersistentTopicsSetSchemaValidationEnforcedTopic) (nonPersistentTopicsSetSchemaValidationEnforcedAuthoritative) nonPersistentTopicsSetSchemaValidationEnforcedBody

-- ^ 
type NonPersistentTopicsSetShadowTopicsAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "shadowTopics" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] [Text] :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsSetShadowTopicsParameters = NonPersistentTopicsSetShadowTopicsParameters
  { nonPersistentTopicsSetShadowTopicsTenant :: Text -- ^ 
  , nonPersistentTopicsSetShadowTopicsNamespace :: Text -- ^ 
  , nonPersistentTopicsSetShadowTopicsTopic :: Text -- ^ 
  , nonPersistentTopicsSetShadowTopicsBody :: [Text] -- ^ List of shadow topics
  , nonPersistentTopicsSetShadowTopicsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetShadowTopics :: NonPersistentTopicsSetShadowTopicsParameters -> ClientM NoContent
nonPersistentTopicsSetShadowTopics NonPersistentTopicsSetShadowTopicsParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetShadowTopicsAPI) (nonPersistentTopicsSetShadowTopicsTenant) (nonPersistentTopicsSetShadowTopicsNamespace) (nonPersistentTopicsSetShadowTopicsTopic) (nonPersistentTopicsSetShadowTopicsAuthoritative) nonPersistentTopicsSetShadowTopicsBody

-- ^ 
type NonPersistentTopicsSetSubscribeRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscribeRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] SubscribeRate :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetSubscribeRateParameters = NonPersistentTopicsSetSubscribeRateParameters
  { nonPersistentTopicsSetSubscribeRateTenant :: Text -- ^ 
  , nonPersistentTopicsSetSubscribeRateNamespace :: Text -- ^ 
  , nonPersistentTopicsSetSubscribeRateTopic :: Text -- ^ 
  , nonPersistentTopicsSetSubscribeRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetSubscribeRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetSubscribeRateBody :: SubscribeRate -- ^ Subscribe rate for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetSubscribeRate :: NonPersistentTopicsSetSubscribeRateParameters -> ClientM NoContent
nonPersistentTopicsSetSubscribeRate NonPersistentTopicsSetSubscribeRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetSubscribeRateAPI) (nonPersistentTopicsSetSubscribeRateTenant) (nonPersistentTopicsSetSubscribeRateNamespace) (nonPersistentTopicsSetSubscribeRateTopic) (nonPersistentTopicsSetSubscribeRateIsGlobal) (nonPersistentTopicsSetSubscribeRateAuthoritative) nonPersistentTopicsSetSubscribeRateBody

-- ^ 
type NonPersistentTopicsSetSubscriptionDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionDispatchRate" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetSubscriptionDispatchRateParameters = NonPersistentTopicsSetSubscriptionDispatchRateParameters
  { nonPersistentTopicsSetSubscriptionDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetSubscriptionDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetSubscriptionDispatchRateBody :: DispatchRateImpl -- ^ Subscription message dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetSubscriptionDispatchRate :: NonPersistentTopicsSetSubscriptionDispatchRateParameters -> ClientM NoContent
nonPersistentTopicsSetSubscriptionDispatchRate NonPersistentTopicsSetSubscriptionDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetSubscriptionDispatchRateAPI) (nonPersistentTopicsSetSubscriptionDispatchRateTenant) (nonPersistentTopicsSetSubscriptionDispatchRateNamespace) (nonPersistentTopicsSetSubscriptionDispatchRateTopic) (nonPersistentTopicsSetSubscriptionDispatchRateAuthoritative) (nonPersistentTopicsSetSubscriptionDispatchRateIsGlobal) nonPersistentTopicsSetSubscriptionDispatchRateBody

-- ^ 
type NonPersistentTopicsSetSubscriptionLevelDispatchRateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> Capture "subName" Text :> "dispatchRate" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetSubscriptionLevelDispatchRateParameters = NonPersistentTopicsSetSubscriptionLevelDispatchRateParameters
  { nonPersistentTopicsSetSubscriptionLevelDispatchRateTenant :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionLevelDispatchRateNamespace :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionLevelDispatchRateTopic :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionLevelDispatchRateSubName :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionLevelDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetSubscriptionLevelDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetSubscriptionLevelDispatchRateBody :: DispatchRateImpl -- ^ Subscription message dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetSubscriptionLevelDispatchRate :: NonPersistentTopicsSetSubscriptionLevelDispatchRateParameters -> ClientM NoContent
nonPersistentTopicsSetSubscriptionLevelDispatchRate NonPersistentTopicsSetSubscriptionLevelDispatchRateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetSubscriptionLevelDispatchRateAPI) (nonPersistentTopicsSetSubscriptionLevelDispatchRateTenant) (nonPersistentTopicsSetSubscriptionLevelDispatchRateNamespace) (nonPersistentTopicsSetSubscriptionLevelDispatchRateTopic) (nonPersistentTopicsSetSubscriptionLevelDispatchRateSubName) (nonPersistentTopicsSetSubscriptionLevelDispatchRateAuthoritative) (nonPersistentTopicsSetSubscriptionLevelDispatchRateIsGlobal) nonPersistentTopicsSetSubscriptionLevelDispatchRateBody

-- ^ 
type NonPersistentTopicsSetSubscriptionTypesEnabledAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionTypesEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSetSubscriptionTypesEnabledParameters = NonPersistentTopicsSetSubscriptionTypesEnabledParameters
  { nonPersistentTopicsSetSubscriptionTypesEnabledTenant :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionTypesEnabledNamespace :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionTypesEnabledTopic :: Text -- ^ 
  , nonPersistentTopicsSetSubscriptionTypesEnabledIsGlobal :: Maybe Bool -- ^ 
  , nonPersistentTopicsSetSubscriptionTypesEnabledAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsSetSubscriptionTypesEnabledBody :: [Text] -- ^ Enable sub types for the specified topic
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSetSubscriptionTypesEnabled :: NonPersistentTopicsSetSubscriptionTypesEnabledParameters -> ClientM NoContent
nonPersistentTopicsSetSubscriptionTypesEnabled NonPersistentTopicsSetSubscriptionTypesEnabledParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSetSubscriptionTypesEnabledAPI) (nonPersistentTopicsSetSubscriptionTypesEnabledTenant) (nonPersistentTopicsSetSubscriptionTypesEnabledNamespace) (nonPersistentTopicsSetSubscriptionTypesEnabledTopic) (nonPersistentTopicsSetSubscriptionTypesEnabledIsGlobal) (nonPersistentTopicsSetSubscriptionTypesEnabledAuthoritative) nonPersistentTopicsSetSubscriptionTypesEnabledBody

-- ^ Completely clears the backlog on the subscription.
type NonPersistentTopicsSkipAllMessagesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "skip_all" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSkipAllMessagesParameters = NonPersistentTopicsSkipAllMessagesParameters
  { nonPersistentTopicsSkipAllMessagesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsSkipAllMessagesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsSkipAllMessagesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsSkipAllMessagesSubName :: Text -- ^ Name of subscription
  , nonPersistentTopicsSkipAllMessagesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSkipAllMessages :: NonPersistentTopicsSkipAllMessagesParameters -> ClientM NoContent
nonPersistentTopicsSkipAllMessages NonPersistentTopicsSkipAllMessagesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSkipAllMessagesAPI) (nonPersistentTopicsSkipAllMessagesTenant) (nonPersistentTopicsSkipAllMessagesNamespace) (nonPersistentTopicsSkipAllMessagesTopic) (nonPersistentTopicsSkipAllMessagesSubName) (nonPersistentTopicsSkipAllMessagesAuthoritative)

-- ^ 
type NonPersistentTopicsSkipMessagesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "skip" :> Capture "numMessages" Int :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsSkipMessagesParameters = NonPersistentTopicsSkipMessagesParameters
  { nonPersistentTopicsSkipMessagesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsSkipMessagesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsSkipMessagesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsSkipMessagesSubName :: Text -- ^ Name of subscription
  , nonPersistentTopicsSkipMessagesNumMessages :: Int -- ^ The number of messages to skip
  , nonPersistentTopicsSkipMessagesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsSkipMessages :: NonPersistentTopicsSkipMessagesParameters -> ClientM NoContent
nonPersistentTopicsSkipMessages NonPersistentTopicsSkipMessagesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsSkipMessagesAPI) (nonPersistentTopicsSkipMessagesTenant) (nonPersistentTopicsSkipMessagesNamespace) (nonPersistentTopicsSkipMessagesTopic) (nonPersistentTopicsSkipMessagesSubName) (nonPersistentTopicsSkipMessagesNumMessages) (nonPersistentTopicsSkipMessagesAuthoritative)

-- ^ 
type NonPersistentTopicsTerminateAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "terminate" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] MessageIdAdv

data NonPersistentTopicsTerminateParameters = NonPersistentTopicsTerminateParameters
  { nonPersistentTopicsTerminateTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsTerminateNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsTerminateTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsTerminateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsTerminate :: NonPersistentTopicsTerminateParameters -> ClientM MessageIdAdv
nonPersistentTopicsTerminate NonPersistentTopicsTerminateParameters {..} = client (Proxy :: Proxy NonPersistentTopicsTerminateAPI) (nonPersistentTopicsTerminateTenant) (nonPersistentTopicsTerminateNamespace) (nonPersistentTopicsTerminateTopic) (nonPersistentTopicsTerminateAuthoritative)

-- ^ 
type NonPersistentTopicsTerminatePartitionedTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "terminate" :> "partitions" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsTerminatePartitionedTopicParameters = NonPersistentTopicsTerminatePartitionedTopicParameters
  { nonPersistentTopicsTerminatePartitionedTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsTerminatePartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsTerminatePartitionedTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsTerminatePartitionedTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsTerminatePartitionedTopic :: NonPersistentTopicsTerminatePartitionedTopicParameters -> ClientM NoContent
nonPersistentTopicsTerminatePartitionedTopic NonPersistentTopicsTerminatePartitionedTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsTerminatePartitionedTopicAPI) (nonPersistentTopicsTerminatePartitionedTopicTenant) (nonPersistentTopicsTerminatePartitionedTopicNamespace) (nonPersistentTopicsTerminatePartitionedTopicTopic) (nonPersistentTopicsTerminatePartitionedTopicAuthoritative)

-- ^ 
type NonPersistentTopicsTriggerOffloadAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offload" :> QueryParam "authoritative" Bool :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsTriggerOffloadParameters = NonPersistentTopicsTriggerOffloadParameters
  { nonPersistentTopicsTriggerOffloadTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsTriggerOffloadNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsTriggerOffloadTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsTriggerOffloadAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsTriggerOffload :: NonPersistentTopicsTriggerOffloadParameters -> ClientM NoContent
nonPersistentTopicsTriggerOffload NonPersistentTopicsTriggerOffloadParameters {..} = client (Proxy :: Proxy NonPersistentTopicsTriggerOffloadAPI) (nonPersistentTopicsTriggerOffloadTenant) (nonPersistentTopicsTriggerOffloadNamespace) (nonPersistentTopicsTriggerOffloadTopic) (nonPersistentTopicsTriggerOffloadAuthoritative)

-- ^ 
type NonPersistentTopicsTrimTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "trim" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsTrimTopicParameters = NonPersistentTopicsTrimTopicParameters
  { nonPersistentTopicsTrimTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsTrimTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsTrimTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsTrimTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsTrimTopic :: NonPersistentTopicsTrimTopicParameters -> ClientM NoContent
nonPersistentTopicsTrimTopic NonPersistentTopicsTrimTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsTrimTopicAPI) (nonPersistentTopicsTrimTopicTenant) (nonPersistentTopicsTrimTopicNamespace) (nonPersistentTopicsTrimTopicTopic) (nonPersistentTopicsTrimTopicAuthoritative)

-- ^ NonPersistentTopic does not support truncate.
type NonPersistentTopicsTruncateTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "truncate" :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data NonPersistentTopicsTruncateTopicParameters = NonPersistentTopicsTruncateTopicParameters
  { nonPersistentTopicsTruncateTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsTruncateTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsTruncateTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsTruncateTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsTruncateTopic :: NonPersistentTopicsTruncateTopicParameters -> ClientM NoContent
nonPersistentTopicsTruncateTopic NonPersistentTopicsTruncateTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsTruncateTopicAPI) (nonPersistentTopicsTruncateTopicTenant) (nonPersistentTopicsTruncateTopicNamespace) (nonPersistentTopicsTruncateTopicTopic) (nonPersistentTopicsTruncateTopicAuthoritative)

-- ^ 
type NonPersistentTopicsUnloadTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "unload" :> QueryParam "authoritative" Bool :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsUnloadTopicParameters = NonPersistentTopicsUnloadTopicParameters
  { nonPersistentTopicsUnloadTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsUnloadTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsUnloadTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsUnloadTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

nonPersistentTopicsUnloadTopic :: NonPersistentTopicsUnloadTopicParameters -> ClientM NoContent
nonPersistentTopicsUnloadTopic NonPersistentTopicsUnloadTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsUnloadTopicAPI) (nonPersistentTopicsUnloadTopicTenant) (nonPersistentTopicsUnloadTopicNamespace) (nonPersistentTopicsUnloadTopicTopic) (nonPersistentTopicsUnloadTopicAuthoritative)

-- ^ It increments partitions of existing partitioned-topic
type NonPersistentTopicsUpdatePartitionedTopicAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitions" :> QueryParam "updateLocalTopicOnly" Bool :> QueryParam "authoritative" Bool :> QueryParam "force" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data NonPersistentTopicsUpdatePartitionedTopicParameters = NonPersistentTopicsUpdatePartitionedTopicParameters
  { nonPersistentTopicsUpdatePartitionedTopicTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsUpdatePartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsUpdatePartitionedTopicTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsUpdatePartitionedTopicBody :: Int -- ^ The number of partitions for the topic
  , nonPersistentTopicsUpdatePartitionedTopicUpdateLocalTopicOnly :: Maybe Bool -- ^ 
  , nonPersistentTopicsUpdatePartitionedTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsUpdatePartitionedTopicForce :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

nonPersistentTopicsUpdatePartitionedTopic :: NonPersistentTopicsUpdatePartitionedTopicParameters -> ClientM NoContent
nonPersistentTopicsUpdatePartitionedTopic NonPersistentTopicsUpdatePartitionedTopicParameters {..} = client (Proxy :: Proxy NonPersistentTopicsUpdatePartitionedTopicAPI) (nonPersistentTopicsUpdatePartitionedTopicTenant) (nonPersistentTopicsUpdatePartitionedTopicNamespace) (nonPersistentTopicsUpdatePartitionedTopicTopic) (nonPersistentTopicsUpdatePartitionedTopicUpdateLocalTopicOnly) (nonPersistentTopicsUpdatePartitionedTopicAuthoritative) (nonPersistentTopicsUpdatePartitionedTopicForce) nonPersistentTopicsUpdatePartitionedTopicBody

-- ^ 
type NonPersistentTopicsUpdatePropertiesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "properties" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] (Map.Map String Text) :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsUpdatePropertiesParameters = NonPersistentTopicsUpdatePropertiesParameters
  { nonPersistentTopicsUpdatePropertiesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsUpdatePropertiesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsUpdatePropertiesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsUpdatePropertiesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsUpdatePropertiesBody :: (Map.Map String Text) -- ^ Key value pair properties for the topic metadata
  } deriving (Show, Eq, Generic)

nonPersistentTopicsUpdateProperties :: NonPersistentTopicsUpdatePropertiesParameters -> ClientM NoContent
nonPersistentTopicsUpdateProperties NonPersistentTopicsUpdatePropertiesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsUpdatePropertiesAPI) (nonPersistentTopicsUpdatePropertiesTenant) (nonPersistentTopicsUpdatePropertiesNamespace) (nonPersistentTopicsUpdatePropertiesTopic) (nonPersistentTopicsUpdatePropertiesAuthoritative) nonPersistentTopicsUpdatePropertiesBody

-- ^ 
type NonPersistentTopicsUpdateSubscriptionPropertiesAPI =
      "admin" :> "v2" :> "non-persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "properties" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] (Map.Map String Text) :> Verb 'PUT 200 '[JSON] NoContent

data NonPersistentTopicsUpdateSubscriptionPropertiesParameters = NonPersistentTopicsUpdateSubscriptionPropertiesParameters
  { nonPersistentTopicsUpdateSubscriptionPropertiesTenant :: Text -- ^ Specify the tenant
  , nonPersistentTopicsUpdateSubscriptionPropertiesNamespace :: Text -- ^ Specify the namespace
  , nonPersistentTopicsUpdateSubscriptionPropertiesTopic :: Text -- ^ Specify topic name
  , nonPersistentTopicsUpdateSubscriptionPropertiesSubName :: Text -- ^ Subscription to update
  , nonPersistentTopicsUpdateSubscriptionPropertiesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , nonPersistentTopicsUpdateSubscriptionPropertiesBody :: (Map.Map String Text) -- ^ The new properties
  } deriving (Show, Eq, Generic)

nonPersistentTopicsUpdateSubscriptionProperties :: NonPersistentTopicsUpdateSubscriptionPropertiesParameters -> ClientM NoContent
nonPersistentTopicsUpdateSubscriptionProperties NonPersistentTopicsUpdateSubscriptionPropertiesParameters {..} = client (Proxy :: Proxy NonPersistentTopicsUpdateSubscriptionPropertiesAPI) (nonPersistentTopicsUpdateSubscriptionPropertiesTenant) (nonPersistentTopicsUpdateSubscriptionPropertiesNamespace) (nonPersistentTopicsUpdateSubscriptionPropertiesTopic) (nonPersistentTopicsUpdateSubscriptionPropertiesSubName) (nonPersistentTopicsUpdateSubscriptionPropertiesAuthoritative) nonPersistentTopicsUpdateSubscriptionPropertiesBody

-- ^ 
type PersistentTopicsAnalyzeSubscriptionBacklogAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "analyzeBacklog" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] ResetCursorData :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsAnalyzeSubscriptionBacklogParameters = PersistentTopicsAnalyzeSubscriptionBacklogParameters
  { persistentTopicsAnalyzeSubscriptionBacklogTenant :: Text -- ^ Specify the tenant
  , persistentTopicsAnalyzeSubscriptionBacklogNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsAnalyzeSubscriptionBacklogTopic :: Text -- ^ Specify topic name
  , persistentTopicsAnalyzeSubscriptionBacklogSubName :: Text -- ^ Subscription
  , persistentTopicsAnalyzeSubscriptionBacklogAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsAnalyzeSubscriptionBacklogPosition :: ResetCursorData -- ^ messageId to start the analysis
  } deriving (Show, Eq, Generic)

persistentTopicsAnalyzeSubscriptionBacklog :: PersistentTopicsAnalyzeSubscriptionBacklogParameters -> ClientM NoContent
persistentTopicsAnalyzeSubscriptionBacklog PersistentTopicsAnalyzeSubscriptionBacklogParameters {..} = client (Proxy :: Proxy PersistentTopicsAnalyzeSubscriptionBacklogAPI) (persistentTopicsAnalyzeSubscriptionBacklogTenant) (persistentTopicsAnalyzeSubscriptionBacklogNamespace) (persistentTopicsAnalyzeSubscriptionBacklogTopic) (persistentTopicsAnalyzeSubscriptionBacklogSubName) (persistentTopicsAnalyzeSubscriptionBacklogAuthoritative) persistentTopicsAnalyzeSubscriptionBacklogPosition

-- ^ 
type PersistentTopicsCompactAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compaction" :> QueryParam "authoritative" Bool :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsCompactParameters = PersistentTopicsCompactParameters
  { persistentTopicsCompactTenant :: Text -- ^ Specify the tenant
  , persistentTopicsCompactNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsCompactTopic :: Text -- ^ Specify topic name
  , persistentTopicsCompactAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsCompact :: PersistentTopicsCompactParameters -> ClientM NoContent
persistentTopicsCompact PersistentTopicsCompactParameters {..} = client (Proxy :: Proxy PersistentTopicsCompactAPI) (persistentTopicsCompactTenant) (persistentTopicsCompactNamespace) (persistentTopicsCompactTopic) (persistentTopicsCompactAuthoritative)

-- ^ 
type PersistentTopicsCompactionStatusAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compaction" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] LongRunningProcessStatus

data PersistentTopicsCompactionStatusParameters = PersistentTopicsCompactionStatusParameters
  { persistentTopicsCompactionStatusTenant :: Text -- ^ Specify the tenant
  , persistentTopicsCompactionStatusNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsCompactionStatusTopic :: Text -- ^ Specify topic name
  , persistentTopicsCompactionStatusAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsCompactionStatus :: PersistentTopicsCompactionStatusParameters -> ClientM LongRunningProcessStatus
persistentTopicsCompactionStatus PersistentTopicsCompactionStatusParameters {..} = client (Proxy :: Proxy PersistentTopicsCompactionStatusAPI) (persistentTopicsCompactionStatusTenant) (persistentTopicsCompactionStatusNamespace) (persistentTopicsCompactionStatusTopic) (persistentTopicsCompactionStatusAuthoritative)

-- ^ 
type PersistentTopicsCreateMissedPartitionsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "createMissedPartitions" :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsCreateMissedPartitionsParameters = PersistentTopicsCreateMissedPartitionsParameters
  { persistentTopicsCreateMissedPartitionsTenant :: Text -- ^ Specify the tenant
  , persistentTopicsCreateMissedPartitionsNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsCreateMissedPartitionsTopic :: Text -- ^ Specify topic name
  } deriving (Show, Eq, Generic)

persistentTopicsCreateMissedPartitions :: PersistentTopicsCreateMissedPartitionsParameters -> ClientM NoContent
persistentTopicsCreateMissedPartitions PersistentTopicsCreateMissedPartitionsParameters {..} = client (Proxy :: Proxy PersistentTopicsCreateMissedPartitionsAPI) (persistentTopicsCreateMissedPartitionsTenant) (persistentTopicsCreateMissedPartitionsNamespace) (persistentTopicsCreateMissedPartitionsTopic)

-- ^ This is the only REST endpoint from which non-partitioned topics could be created.
type PersistentTopicsCreateNonPartitionedTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> QueryParam "authoritative" Bool :> ReqBody '[JSON] (Map.Map String Text) :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsCreateNonPartitionedTopicParameters = PersistentTopicsCreateNonPartitionedTopicParameters
  { persistentTopicsCreateNonPartitionedTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsCreateNonPartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsCreateNonPartitionedTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsCreateNonPartitionedTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsCreateNonPartitionedTopicBody :: (Map.Map String Text) -- ^ Key value pair properties for the topic metadata
  } deriving (Show, Eq, Generic)

persistentTopicsCreateNonPartitionedTopic :: PersistentTopicsCreateNonPartitionedTopicParameters -> ClientM NoContent
persistentTopicsCreateNonPartitionedTopic PersistentTopicsCreateNonPartitionedTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsCreateNonPartitionedTopicAPI) (persistentTopicsCreateNonPartitionedTopicTenant) (persistentTopicsCreateNonPartitionedTopicNamespace) (persistentTopicsCreateNonPartitionedTopicTopic) (persistentTopicsCreateNonPartitionedTopicAuthoritative) persistentTopicsCreateNonPartitionedTopicBody

-- ^ It needs to be called before creating a producer on a partitioned topic.
type PersistentTopicsCreatePartitionedTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitions" :> QueryParam "createLocalTopicOnly" Bool :> ReqBody '[JSON] Int :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsCreatePartitionedTopicParameters = PersistentTopicsCreatePartitionedTopicParameters
  { persistentTopicsCreatePartitionedTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsCreatePartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsCreatePartitionedTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsCreatePartitionedTopicBody :: Int -- ^ The number of partitions for the topic
  , persistentTopicsCreatePartitionedTopicCreateLocalTopicOnly :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsCreatePartitionedTopic :: PersistentTopicsCreatePartitionedTopicParameters -> ClientM NoContent
persistentTopicsCreatePartitionedTopic PersistentTopicsCreatePartitionedTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsCreatePartitionedTopicAPI) (persistentTopicsCreatePartitionedTopicTenant) (persistentTopicsCreatePartitionedTopicNamespace) (persistentTopicsCreatePartitionedTopicTopic) (persistentTopicsCreatePartitionedTopicCreateLocalTopicOnly) persistentTopicsCreatePartitionedTopicBody

-- ^ Creates a subscription on the topic at the specified message id
type PersistentTopicsCreateSubscriptionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subscriptionName" Text :> QueryParam "authoritative" Bool :> QueryParam "replicated" Bool :> ReqBody '[JSON] ResetCursorData :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsCreateSubscriptionParameters = PersistentTopicsCreateSubscriptionParameters
  { persistentTopicsCreateSubscriptionTenant :: Text -- ^ Specify the tenant
  , persistentTopicsCreateSubscriptionNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsCreateSubscriptionTopic :: Text -- ^ Specify topic name
  , persistentTopicsCreateSubscriptionSubscriptionName :: Text -- ^ Name of subscription to be created
  , persistentTopicsCreateSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsCreateSubscriptionReplicated :: Maybe Bool -- ^ Is replicated required to perform this operation
  , persistentTopicsCreateSubscriptionMessageId :: ResetCursorData -- ^ messageId where to create the subscription. It can be 'latest', 'earliest' or (ledgerId:entryId)
  } deriving (Show, Eq, Generic)

persistentTopicsCreateSubscription :: PersistentTopicsCreateSubscriptionParameters -> ClientM NoContent
persistentTopicsCreateSubscription PersistentTopicsCreateSubscriptionParameters {..} = client (Proxy :: Proxy PersistentTopicsCreateSubscriptionAPI) (persistentTopicsCreateSubscriptionTenant) (persistentTopicsCreateSubscriptionNamespace) (persistentTopicsCreateSubscriptionTopic) (persistentTopicsCreateSubscriptionSubscriptionName) (persistentTopicsCreateSubscriptionAuthoritative) (persistentTopicsCreateSubscriptionReplicated) persistentTopicsCreateSubscriptionMessageId

-- ^ 
type PersistentTopicsDeleteDeduplicationSnapshotIntervalAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationSnapshotInterval" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeleteDeduplicationSnapshotIntervalParameters = PersistentTopicsDeleteDeduplicationSnapshotIntervalParameters
  { persistentTopicsDeleteDeduplicationSnapshotIntervalTenant :: Text -- ^ 
  , persistentTopicsDeleteDeduplicationSnapshotIntervalNamespace :: Text -- ^ 
  , persistentTopicsDeleteDeduplicationSnapshotIntervalTopic :: Text -- ^ 
  , persistentTopicsDeleteDeduplicationSnapshotIntervalIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsDeleteDeduplicationSnapshotIntervalAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeleteDeduplicationSnapshotInterval :: PersistentTopicsDeleteDeduplicationSnapshotIntervalParameters -> ClientM NoContent
persistentTopicsDeleteDeduplicationSnapshotInterval PersistentTopicsDeleteDeduplicationSnapshotIntervalParameters {..} = client (Proxy :: Proxy PersistentTopicsDeleteDeduplicationSnapshotIntervalAPI) (persistentTopicsDeleteDeduplicationSnapshotIntervalTenant) (persistentTopicsDeleteDeduplicationSnapshotIntervalNamespace) (persistentTopicsDeleteDeduplicationSnapshotIntervalTopic) (persistentTopicsDeleteDeduplicationSnapshotIntervalIsGlobal) (persistentTopicsDeleteDeduplicationSnapshotIntervalAuthoritative)

-- ^ 
type PersistentTopicsDeleteDelayedDeliveryPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "delayedDelivery" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeleteDelayedDeliveryPoliciesParameters = PersistentTopicsDeleteDelayedDeliveryPoliciesParameters
  { persistentTopicsDeleteDelayedDeliveryPoliciesTenant :: Text -- ^ 
  , persistentTopicsDeleteDelayedDeliveryPoliciesNamespace :: Text -- ^ 
  , persistentTopicsDeleteDelayedDeliveryPoliciesTopic :: Text -- ^ 
  , persistentTopicsDeleteDelayedDeliveryPoliciesIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsDeleteDelayedDeliveryPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeleteDelayedDeliveryPolicies :: PersistentTopicsDeleteDelayedDeliveryPoliciesParameters -> ClientM NoContent
persistentTopicsDeleteDelayedDeliveryPolicies PersistentTopicsDeleteDelayedDeliveryPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsDeleteDelayedDeliveryPoliciesAPI) (persistentTopicsDeleteDelayedDeliveryPoliciesTenant) (persistentTopicsDeleteDelayedDeliveryPoliciesNamespace) (persistentTopicsDeleteDelayedDeliveryPoliciesTopic) (persistentTopicsDeleteDelayedDeliveryPoliciesIsGlobal) (persistentTopicsDeleteDelayedDeliveryPoliciesAuthoritative)

-- ^ 
type PersistentTopicsDeleteInactiveTopicPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "inactiveTopicPolicies" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeleteInactiveTopicPoliciesParameters = PersistentTopicsDeleteInactiveTopicPoliciesParameters
  { persistentTopicsDeleteInactiveTopicPoliciesTenant :: Text -- ^ 
  , persistentTopicsDeleteInactiveTopicPoliciesNamespace :: Text -- ^ 
  , persistentTopicsDeleteInactiveTopicPoliciesTopic :: Text -- ^ 
  , persistentTopicsDeleteInactiveTopicPoliciesIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsDeleteInactiveTopicPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeleteInactiveTopicPolicies :: PersistentTopicsDeleteInactiveTopicPoliciesParameters -> ClientM NoContent
persistentTopicsDeleteInactiveTopicPolicies PersistentTopicsDeleteInactiveTopicPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsDeleteInactiveTopicPoliciesAPI) (persistentTopicsDeleteInactiveTopicPoliciesTenant) (persistentTopicsDeleteInactiveTopicPoliciesNamespace) (persistentTopicsDeleteInactiveTopicPoliciesTopic) (persistentTopicsDeleteInactiveTopicPoliciesIsGlobal) (persistentTopicsDeleteInactiveTopicPoliciesAuthoritative)

-- ^ 
type PersistentTopicsDeleteMaxUnackedMessagesOnConsumerAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnConsumer" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters = PersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters
  { persistentTopicsDeleteMaxUnackedMessagesOnConsumerTenant :: Text -- ^ 
  , persistentTopicsDeleteMaxUnackedMessagesOnConsumerNamespace :: Text -- ^ 
  , persistentTopicsDeleteMaxUnackedMessagesOnConsumerTopic :: Text -- ^ 
  , persistentTopicsDeleteMaxUnackedMessagesOnConsumerIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsDeleteMaxUnackedMessagesOnConsumerAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeleteMaxUnackedMessagesOnConsumer :: PersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters -> ClientM NoContent
persistentTopicsDeleteMaxUnackedMessagesOnConsumer PersistentTopicsDeleteMaxUnackedMessagesOnConsumerParameters {..} = client (Proxy :: Proxy PersistentTopicsDeleteMaxUnackedMessagesOnConsumerAPI) (persistentTopicsDeleteMaxUnackedMessagesOnConsumerTenant) (persistentTopicsDeleteMaxUnackedMessagesOnConsumerNamespace) (persistentTopicsDeleteMaxUnackedMessagesOnConsumerTopic) (persistentTopicsDeleteMaxUnackedMessagesOnConsumerIsGlobal) (persistentTopicsDeleteMaxUnackedMessagesOnConsumerAuthoritative)

-- ^ 
type PersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters = PersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters
  { persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionTenant :: Text -- ^ 
  , persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionNamespace :: Text -- ^ 
  , persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionTopic :: Text -- ^ 
  , persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeleteMaxUnackedMessagesOnSubscription :: PersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters -> ClientM NoContent
persistentTopicsDeleteMaxUnackedMessagesOnSubscription PersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionParameters {..} = client (Proxy :: Proxy PersistentTopicsDeleteMaxUnackedMessagesOnSubscriptionAPI) (persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionTenant) (persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionNamespace) (persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionTopic) (persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionIsGlobal) (persistentTopicsDeleteMaxUnackedMessagesOnSubscriptionAuthoritative)

-- ^ It will also delete all the partitions of the topic if it exists.
type PersistentTopicsDeletePartitionedTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitions" :> QueryParam "force" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeletePartitionedTopicParameters = PersistentTopicsDeletePartitionedTopicParameters
  { persistentTopicsDeletePartitionedTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsDeletePartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsDeletePartitionedTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsDeletePartitionedTopicForce :: Maybe Bool -- ^ Stop all producer/consumer/replicator and delete topic forcefully
  , persistentTopicsDeletePartitionedTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeletePartitionedTopic :: PersistentTopicsDeletePartitionedTopicParameters -> ClientM NoContent
persistentTopicsDeletePartitionedTopic PersistentTopicsDeletePartitionedTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsDeletePartitionedTopicAPI) (persistentTopicsDeletePartitionedTopicTenant) (persistentTopicsDeletePartitionedTopicNamespace) (persistentTopicsDeletePartitionedTopicTopic) (persistentTopicsDeletePartitionedTopicForce) (persistentTopicsDeletePartitionedTopicAuthoritative)

-- ^ 
type PersistentTopicsDeleteShadowTopicsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "shadowTopics" :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeleteShadowTopicsParameters = PersistentTopicsDeleteShadowTopicsParameters
  { persistentTopicsDeleteShadowTopicsTenant :: Text -- ^ 
  , persistentTopicsDeleteShadowTopicsNamespace :: Text -- ^ 
  , persistentTopicsDeleteShadowTopicsTopic :: Text -- ^ 
  , persistentTopicsDeleteShadowTopicsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeleteShadowTopics :: PersistentTopicsDeleteShadowTopicsParameters -> ClientM NoContent
persistentTopicsDeleteShadowTopics PersistentTopicsDeleteShadowTopicsParameters {..} = client (Proxy :: Proxy PersistentTopicsDeleteShadowTopicsAPI) (persistentTopicsDeleteShadowTopicsTenant) (persistentTopicsDeleteShadowTopicsNamespace) (persistentTopicsDeleteShadowTopicsTopic) (persistentTopicsDeleteShadowTopicsAuthoritative)

-- ^ The subscription cannot be deleted if delete is not forcefully and there are any active consumers attached to it. Force delete ignores connected consumers and deletes subscription by explicitly closing them.
type PersistentTopicsDeleteSubscriptionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> QueryParam "force" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeleteSubscriptionParameters = PersistentTopicsDeleteSubscriptionParameters
  { persistentTopicsDeleteSubscriptionTenant :: Text -- ^ Specify the tenant
  , persistentTopicsDeleteSubscriptionNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsDeleteSubscriptionTopic :: Text -- ^ Specify topic name
  , persistentTopicsDeleteSubscriptionSubName :: Text -- ^ Subscription to be deleted
  , persistentTopicsDeleteSubscriptionForce :: Maybe Bool -- ^ Disconnect and close all consumers and delete subscription forcefully
  , persistentTopicsDeleteSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeleteSubscription :: PersistentTopicsDeleteSubscriptionParameters -> ClientM NoContent
persistentTopicsDeleteSubscription PersistentTopicsDeleteSubscriptionParameters {..} = client (Proxy :: Proxy PersistentTopicsDeleteSubscriptionAPI) (persistentTopicsDeleteSubscriptionTenant) (persistentTopicsDeleteSubscriptionNamespace) (persistentTopicsDeleteSubscriptionTopic) (persistentTopicsDeleteSubscriptionSubName) (persistentTopicsDeleteSubscriptionForce) (persistentTopicsDeleteSubscriptionAuthoritative)

-- ^ The topic cannot be deleted if delete is not forcefully and there's any active subscription or producer connected to the it. Force delete ignores connected clients and deletes topic by explicitly closing them.
type PersistentTopicsDeleteTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> QueryParam "force" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeleteTopicParameters = PersistentTopicsDeleteTopicParameters
  { persistentTopicsDeleteTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsDeleteTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsDeleteTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsDeleteTopicForce :: Maybe Bool -- ^ Stop all producer/consumer/replicator and delete topic forcefully
  , persistentTopicsDeleteTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeleteTopic :: PersistentTopicsDeleteTopicParameters -> ClientM NoContent
persistentTopicsDeleteTopic PersistentTopicsDeleteTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsDeleteTopicAPI) (persistentTopicsDeleteTopicTenant) (persistentTopicsDeleteTopicNamespace) (persistentTopicsDeleteTopicTopic) (persistentTopicsDeleteTopicForce) (persistentTopicsDeleteTopicAuthoritative)

-- ^ 
type PersistentTopicsDeleteTopicPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "policies" :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsDeleteTopicPoliciesParameters = PersistentTopicsDeleteTopicPoliciesParameters
  { persistentTopicsDeleteTopicPoliciesTenant :: Text -- ^ Specify the tenant
  , persistentTopicsDeleteTopicPoliciesNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsDeleteTopicPoliciesTopic :: Text -- ^ Specify topic name
  , persistentTopicsDeleteTopicPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsDeleteTopicPolicies :: PersistentTopicsDeleteTopicPoliciesParameters -> ClientM NoContent
persistentTopicsDeleteTopicPolicies PersistentTopicsDeleteTopicPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsDeleteTopicPoliciesAPI) (persistentTopicsDeleteTopicPoliciesTenant) (persistentTopicsDeleteTopicPoliciesNamespace) (persistentTopicsDeleteTopicPoliciesTopic) (persistentTopicsDeleteTopicPoliciesAuthoritative)

-- ^ 
type PersistentTopicsExamineMessageAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "examinemessage" :> QueryParam "initialPosition" Text :> QueryParam "messagePosition" Integer :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] NoContent

data PersistentTopicsExamineMessageParameters = PersistentTopicsExamineMessageParameters
  { persistentTopicsExamineMessageTenant :: Text -- ^ Specify the tenant
  , persistentTopicsExamineMessageNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsExamineMessageTopic :: Text -- ^ Specify topic name
  , persistentTopicsExamineMessageInitialPosition :: Maybe Text -- ^ Relative start position to examine message.It can be 'latest' or 'earliest'
  , persistentTopicsExamineMessageMessagePosition :: Maybe Integer -- ^ The position of messages (default 1)
  , persistentTopicsExamineMessageAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsExamineMessage :: PersistentTopicsExamineMessageParameters -> ClientM NoContent
persistentTopicsExamineMessage PersistentTopicsExamineMessageParameters {..} = client (Proxy :: Proxy PersistentTopicsExamineMessageAPI) (persistentTopicsExamineMessageTenant) (persistentTopicsExamineMessageNamespace) (persistentTopicsExamineMessageTopic) (persistentTopicsExamineMessageInitialPosition) (persistentTopicsExamineMessageMessagePosition) (persistentTopicsExamineMessageAuthoritative)

-- ^ 
type PersistentTopicsExpireMessagesForAllSubscriptionsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "all_subscription" :> "expireMessages" :> Capture "expireTimeInSeconds" Int :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsExpireMessagesForAllSubscriptionsParameters = PersistentTopicsExpireMessagesForAllSubscriptionsParameters
  { persistentTopicsExpireMessagesForAllSubscriptionsTenant :: Text -- ^ Specify the tenant
  , persistentTopicsExpireMessagesForAllSubscriptionsNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsExpireMessagesForAllSubscriptionsTopic :: Text -- ^ Specify topic name
  , persistentTopicsExpireMessagesForAllSubscriptionsExpireTimeInSeconds :: Int -- ^ Expires beyond the specified number of seconds
  , persistentTopicsExpireMessagesForAllSubscriptionsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsExpireMessagesForAllSubscriptions :: PersistentTopicsExpireMessagesForAllSubscriptionsParameters -> ClientM NoContent
persistentTopicsExpireMessagesForAllSubscriptions PersistentTopicsExpireMessagesForAllSubscriptionsParameters {..} = client (Proxy :: Proxy PersistentTopicsExpireMessagesForAllSubscriptionsAPI) (persistentTopicsExpireMessagesForAllSubscriptionsTenant) (persistentTopicsExpireMessagesForAllSubscriptionsNamespace) (persistentTopicsExpireMessagesForAllSubscriptionsTopic) (persistentTopicsExpireMessagesForAllSubscriptionsExpireTimeInSeconds) (persistentTopicsExpireMessagesForAllSubscriptionsAuthoritative)

-- ^ 
type PersistentTopicsExpireTopicMessagesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "expireMessages" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] ResetCursorData :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsExpireTopicMessagesParameters = PersistentTopicsExpireTopicMessagesParameters
  { persistentTopicsExpireTopicMessagesTenant :: Text -- ^ Specify the tenant
  , persistentTopicsExpireTopicMessagesNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsExpireTopicMessagesTopic :: Text -- ^ Specify topic name
  , persistentTopicsExpireTopicMessagesSubName :: Text -- ^ Subscription to be Expiry messages on
  , persistentTopicsExpireTopicMessagesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsExpireTopicMessagesMessageId :: ResetCursorData -- ^ messageId to reset back to (ledgerId:entryId)
  } deriving (Show, Eq, Generic)

persistentTopicsExpireTopicMessages :: PersistentTopicsExpireTopicMessagesParameters -> ClientM NoContent
persistentTopicsExpireTopicMessages PersistentTopicsExpireTopicMessagesParameters {..} = client (Proxy :: Proxy PersistentTopicsExpireTopicMessagesAPI) (persistentTopicsExpireTopicMessagesTenant) (persistentTopicsExpireTopicMessagesNamespace) (persistentTopicsExpireTopicMessagesTopic) (persistentTopicsExpireTopicMessagesSubName) (persistentTopicsExpireTopicMessagesAuthoritative) persistentTopicsExpireTopicMessagesMessageId

-- ^ 
type PersistentTopicsExpireTopicMessagesByExpireTimeInSecondsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "expireMessages" :> Capture "expireTimeInSeconds" Int :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsExpireTopicMessagesByExpireTimeInSecondsParameters = PersistentTopicsExpireTopicMessagesByExpireTimeInSecondsParameters
  { persistentTopicsExpireTopicMessagesByExpireTimeInSecondsTenant :: Text -- ^ Specify the tenant
  , persistentTopicsExpireTopicMessagesByExpireTimeInSecondsNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsExpireTopicMessagesByExpireTimeInSecondsTopic :: Text -- ^ Specify topic name
  , persistentTopicsExpireTopicMessagesByExpireTimeInSecondsSubName :: Text -- ^ Subscription to be Expiry messages on
  , persistentTopicsExpireTopicMessagesByExpireTimeInSecondsExpireTimeInSeconds :: Int -- ^ Expires beyond the specified number of seconds
  , persistentTopicsExpireTopicMessagesByExpireTimeInSecondsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsExpireTopicMessagesByExpireTimeInSeconds :: PersistentTopicsExpireTopicMessagesByExpireTimeInSecondsParameters -> ClientM NoContent
persistentTopicsExpireTopicMessagesByExpireTimeInSeconds PersistentTopicsExpireTopicMessagesByExpireTimeInSecondsParameters {..} = client (Proxy :: Proxy PersistentTopicsExpireTopicMessagesByExpireTimeInSecondsAPI) (persistentTopicsExpireTopicMessagesByExpireTimeInSecondsTenant) (persistentTopicsExpireTopicMessagesByExpireTimeInSecondsNamespace) (persistentTopicsExpireTopicMessagesByExpireTimeInSecondsTopic) (persistentTopicsExpireTopicMessagesByExpireTimeInSecondsSubName) (persistentTopicsExpireTopicMessagesByExpireTimeInSecondsExpireTimeInSeconds) (persistentTopicsExpireTopicMessagesByExpireTimeInSecondsAuthoritative)

-- ^ 
type PersistentTopicsGetAutoSubscriptionCreationAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "autoSubscriptionCreation" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] AutoSubscriptionCreationOverrideImpl

data PersistentTopicsGetAutoSubscriptionCreationParameters = PersistentTopicsGetAutoSubscriptionCreationParameters
  { persistentTopicsGetAutoSubscriptionCreationTenant :: Text -- ^ 
  , persistentTopicsGetAutoSubscriptionCreationNamespace :: Text -- ^ 
  , persistentTopicsGetAutoSubscriptionCreationTopic :: Text -- ^ 
  , persistentTopicsGetAutoSubscriptionCreationApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetAutoSubscriptionCreationIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetAutoSubscriptionCreationAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsGetAutoSubscriptionCreation :: PersistentTopicsGetAutoSubscriptionCreationParameters -> ClientM AutoSubscriptionCreationOverrideImpl
persistentTopicsGetAutoSubscriptionCreation PersistentTopicsGetAutoSubscriptionCreationParameters {..} = client (Proxy :: Proxy PersistentTopicsGetAutoSubscriptionCreationAPI) (persistentTopicsGetAutoSubscriptionCreationTenant) (persistentTopicsGetAutoSubscriptionCreationNamespace) (persistentTopicsGetAutoSubscriptionCreationTopic) (persistentTopicsGetAutoSubscriptionCreationApplied) (persistentTopicsGetAutoSubscriptionCreationIsGlobal) (persistentTopicsGetAutoSubscriptionCreationAuthoritative)

-- ^ 
type PersistentTopicsGetBacklogAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlog" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PersistentOfflineTopicStats

data PersistentTopicsGetBacklogParameters = PersistentTopicsGetBacklogParameters
  { persistentTopicsGetBacklogTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetBacklogNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetBacklogTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetBacklogAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetBacklog :: PersistentTopicsGetBacklogParameters -> ClientM PersistentOfflineTopicStats
persistentTopicsGetBacklog PersistentTopicsGetBacklogParameters {..} = client (Proxy :: Proxy PersistentTopicsGetBacklogAPI) (persistentTopicsGetBacklogTenant) (persistentTopicsGetBacklogNamespace) (persistentTopicsGetBacklogTopic) (persistentTopicsGetBacklogAuthoritative)

-- ^ 
type PersistentTopicsGetBacklogQuotaMapAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlogQuotaMap" :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> Verb 'GET 200 '[JSON] ((Map.Map String BacklogQuota))

data PersistentTopicsGetBacklogQuotaMapParameters = PersistentTopicsGetBacklogQuotaMapParameters
  { persistentTopicsGetBacklogQuotaMapTenant :: Text -- ^ 
  , persistentTopicsGetBacklogQuotaMapNamespace :: Text -- ^ 
  , persistentTopicsGetBacklogQuotaMapTopic :: Text -- ^ 
  , persistentTopicsGetBacklogQuotaMapApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetBacklogQuotaMapAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsGetBacklogQuotaMapIsGlobal :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsGetBacklogQuotaMap :: PersistentTopicsGetBacklogQuotaMapParameters -> ClientM (Map.Map String BacklogQuota)
persistentTopicsGetBacklogQuotaMap PersistentTopicsGetBacklogQuotaMapParameters {..} = client (Proxy :: Proxy PersistentTopicsGetBacklogQuotaMapAPI) (persistentTopicsGetBacklogQuotaMapTenant) (persistentTopicsGetBacklogQuotaMapNamespace) (persistentTopicsGetBacklogQuotaMapTopic) (persistentTopicsGetBacklogQuotaMapApplied) (persistentTopicsGetBacklogQuotaMapAuthoritative) (persistentTopicsGetBacklogQuotaMapIsGlobal)

-- ^ 
type PersistentTopicsGetBacklogSizeByMessageIdAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlogSize" :> QueryParam "authoritative" Bool :> Verb 'PUT 200 '[JSON] Integer

data PersistentTopicsGetBacklogSizeByMessageIdParameters = PersistentTopicsGetBacklogSizeByMessageIdParameters
  { persistentTopicsGetBacklogSizeByMessageIdTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetBacklogSizeByMessageIdNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetBacklogSizeByMessageIdTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetBacklogSizeByMessageIdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetBacklogSizeByMessageId :: PersistentTopicsGetBacklogSizeByMessageIdParameters -> ClientM Integer
persistentTopicsGetBacklogSizeByMessageId PersistentTopicsGetBacklogSizeByMessageIdParameters {..} = client (Proxy :: Proxy PersistentTopicsGetBacklogSizeByMessageIdAPI) (persistentTopicsGetBacklogSizeByMessageIdTenant) (persistentTopicsGetBacklogSizeByMessageIdNamespace) (persistentTopicsGetBacklogSizeByMessageIdTopic) (persistentTopicsGetBacklogSizeByMessageIdAuthoritative)

-- ^ 
type PersistentTopicsGetCompactionThresholdAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compactionThreshold" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Integer

data PersistentTopicsGetCompactionThresholdParameters = PersistentTopicsGetCompactionThresholdParameters
  { persistentTopicsGetCompactionThresholdTenant :: Text -- ^ 
  , persistentTopicsGetCompactionThresholdNamespace :: Text -- ^ 
  , persistentTopicsGetCompactionThresholdTopic :: Text -- ^ 
  , persistentTopicsGetCompactionThresholdApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetCompactionThresholdIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetCompactionThresholdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetCompactionThreshold :: PersistentTopicsGetCompactionThresholdParameters -> ClientM Integer
persistentTopicsGetCompactionThreshold PersistentTopicsGetCompactionThresholdParameters {..} = client (Proxy :: Proxy PersistentTopicsGetCompactionThresholdAPI) (persistentTopicsGetCompactionThresholdTenant) (persistentTopicsGetCompactionThresholdNamespace) (persistentTopicsGetCompactionThresholdTopic) (persistentTopicsGetCompactionThresholdApplied) (persistentTopicsGetCompactionThresholdIsGlobal) (persistentTopicsGetCompactionThresholdAuthoritative)

-- ^ 
type PersistentTopicsGetDeduplicationAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationEnabled" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Bool

data PersistentTopicsGetDeduplicationParameters = PersistentTopicsGetDeduplicationParameters
  { persistentTopicsGetDeduplicationTenant :: Text -- ^ 
  , persistentTopicsGetDeduplicationNamespace :: Text -- ^ 
  , persistentTopicsGetDeduplicationTopic :: Text -- ^ 
  , persistentTopicsGetDeduplicationApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetDeduplicationIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetDeduplicationAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetDeduplication :: PersistentTopicsGetDeduplicationParameters -> ClientM Bool
persistentTopicsGetDeduplication PersistentTopicsGetDeduplicationParameters {..} = client (Proxy :: Proxy PersistentTopicsGetDeduplicationAPI) (persistentTopicsGetDeduplicationTenant) (persistentTopicsGetDeduplicationNamespace) (persistentTopicsGetDeduplicationTopic) (persistentTopicsGetDeduplicationApplied) (persistentTopicsGetDeduplicationIsGlobal) (persistentTopicsGetDeduplicationAuthoritative)

-- ^ 
type PersistentTopicsGetDeduplicationSnapshotIntervalAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationSnapshotInterval" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetDeduplicationSnapshotIntervalParameters = PersistentTopicsGetDeduplicationSnapshotIntervalParameters
  { persistentTopicsGetDeduplicationSnapshotIntervalTenant :: Text -- ^ 
  , persistentTopicsGetDeduplicationSnapshotIntervalNamespace :: Text -- ^ 
  , persistentTopicsGetDeduplicationSnapshotIntervalTopic :: Text -- ^ 
  , persistentTopicsGetDeduplicationSnapshotIntervalIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetDeduplicationSnapshotIntervalAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetDeduplicationSnapshotInterval :: PersistentTopicsGetDeduplicationSnapshotIntervalParameters -> ClientM Int
persistentTopicsGetDeduplicationSnapshotInterval PersistentTopicsGetDeduplicationSnapshotIntervalParameters {..} = client (Proxy :: Proxy PersistentTopicsGetDeduplicationSnapshotIntervalAPI) (persistentTopicsGetDeduplicationSnapshotIntervalTenant) (persistentTopicsGetDeduplicationSnapshotIntervalNamespace) (persistentTopicsGetDeduplicationSnapshotIntervalTopic) (persistentTopicsGetDeduplicationSnapshotIntervalIsGlobal) (persistentTopicsGetDeduplicationSnapshotIntervalAuthoritative)

-- ^ 
type PersistentTopicsGetDelayedDeliveryPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "delayedDelivery" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DelayedDeliveryPolicies

data PersistentTopicsGetDelayedDeliveryPoliciesParameters = PersistentTopicsGetDelayedDeliveryPoliciesParameters
  { persistentTopicsGetDelayedDeliveryPoliciesTenant :: Text -- ^ 
  , persistentTopicsGetDelayedDeliveryPoliciesNamespace :: Text -- ^ 
  , persistentTopicsGetDelayedDeliveryPoliciesTopic :: Text -- ^ 
  , persistentTopicsGetDelayedDeliveryPoliciesIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetDelayedDeliveryPoliciesApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetDelayedDeliveryPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetDelayedDeliveryPolicies :: PersistentTopicsGetDelayedDeliveryPoliciesParameters -> ClientM DelayedDeliveryPolicies
persistentTopicsGetDelayedDeliveryPolicies PersistentTopicsGetDelayedDeliveryPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsGetDelayedDeliveryPoliciesAPI) (persistentTopicsGetDelayedDeliveryPoliciesTenant) (persistentTopicsGetDelayedDeliveryPoliciesNamespace) (persistentTopicsGetDelayedDeliveryPoliciesTopic) (persistentTopicsGetDelayedDeliveryPoliciesIsGlobal) (persistentTopicsGetDelayedDeliveryPoliciesApplied) (persistentTopicsGetDelayedDeliveryPoliciesAuthoritative)

-- ^ 
type PersistentTopicsGetDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatchRate" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DispatchRateImpl

data PersistentTopicsGetDispatchRateParameters = PersistentTopicsGetDispatchRateParameters
  { persistentTopicsGetDispatchRateTenant :: Text -- ^ 
  , persistentTopicsGetDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsGetDispatchRateTopic :: Text -- ^ 
  , persistentTopicsGetDispatchRateApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetDispatchRate :: PersistentTopicsGetDispatchRateParameters -> ClientM DispatchRateImpl
persistentTopicsGetDispatchRate PersistentTopicsGetDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsGetDispatchRateAPI) (persistentTopicsGetDispatchRateTenant) (persistentTopicsGetDispatchRateNamespace) (persistentTopicsGetDispatchRateTopic) (persistentTopicsGetDispatchRateApplied) (persistentTopicsGetDispatchRateIsGlobal) (persistentTopicsGetDispatchRateAuthoritative)

-- ^ 
type PersistentTopicsGetDispatcherPauseOnAckStatePersistentAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatcherPauseOnAckStatePersistent" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters = PersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters
  { persistentTopicsGetDispatcherPauseOnAckStatePersistentTenant :: Text -- ^ 
  , persistentTopicsGetDispatcherPauseOnAckStatePersistentNamespace :: Text -- ^ 
  , persistentTopicsGetDispatcherPauseOnAckStatePersistentTopic :: Text -- ^ 
  , persistentTopicsGetDispatcherPauseOnAckStatePersistentApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetDispatcherPauseOnAckStatePersistentIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetDispatcherPauseOnAckStatePersistentAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetDispatcherPauseOnAckStatePersistent :: PersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters -> ClientM Int
persistentTopicsGetDispatcherPauseOnAckStatePersistent PersistentTopicsGetDispatcherPauseOnAckStatePersistentParameters {..} = client (Proxy :: Proxy PersistentTopicsGetDispatcherPauseOnAckStatePersistentAPI) (persistentTopicsGetDispatcherPauseOnAckStatePersistentTenant) (persistentTopicsGetDispatcherPauseOnAckStatePersistentNamespace) (persistentTopicsGetDispatcherPauseOnAckStatePersistentTopic) (persistentTopicsGetDispatcherPauseOnAckStatePersistentApplied) (persistentTopicsGetDispatcherPauseOnAckStatePersistentIsGlobal) (persistentTopicsGetDispatcherPauseOnAckStatePersistentAuthoritative)

-- ^ 
type PersistentTopicsGetEntryFiltersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "entryFilters" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] EntryFilters

data PersistentTopicsGetEntryFiltersParameters = PersistentTopicsGetEntryFiltersParameters
  { persistentTopicsGetEntryFiltersTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetEntryFiltersNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetEntryFiltersTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetEntryFiltersApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetEntryFiltersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetEntryFiltersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetEntryFilters :: PersistentTopicsGetEntryFiltersParameters -> ClientM EntryFilters
persistentTopicsGetEntryFilters PersistentTopicsGetEntryFiltersParameters {..} = client (Proxy :: Proxy PersistentTopicsGetEntryFiltersAPI) (persistentTopicsGetEntryFiltersTenant) (persistentTopicsGetEntryFiltersNamespace) (persistentTopicsGetEntryFiltersTopic) (persistentTopicsGetEntryFiltersApplied) (persistentTopicsGetEntryFiltersIsGlobal) (persistentTopicsGetEntryFiltersAuthoritative)

-- ^ 
type PersistentTopicsGetInactiveTopicPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "inactiveTopicPolicies" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] InactiveTopicPolicies

data PersistentTopicsGetInactiveTopicPoliciesParameters = PersistentTopicsGetInactiveTopicPoliciesParameters
  { persistentTopicsGetInactiveTopicPoliciesTenant :: Text -- ^ 
  , persistentTopicsGetInactiveTopicPoliciesNamespace :: Text -- ^ 
  , persistentTopicsGetInactiveTopicPoliciesTopic :: Text -- ^ 
  , persistentTopicsGetInactiveTopicPoliciesApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetInactiveTopicPoliciesIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetInactiveTopicPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetInactiveTopicPolicies :: PersistentTopicsGetInactiveTopicPoliciesParameters -> ClientM InactiveTopicPolicies
persistentTopicsGetInactiveTopicPolicies PersistentTopicsGetInactiveTopicPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsGetInactiveTopicPoliciesAPI) (persistentTopicsGetInactiveTopicPoliciesTenant) (persistentTopicsGetInactiveTopicPoliciesNamespace) (persistentTopicsGetInactiveTopicPoliciesTopic) (persistentTopicsGetInactiveTopicPoliciesApplied) (persistentTopicsGetInactiveTopicPoliciesIsGlobal) (persistentTopicsGetInactiveTopicPoliciesAuthoritative)

-- ^ 
type PersistentTopicsGetInternalStatsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "internalStats" :> QueryParam "authoritative" Bool :> QueryParam "metadata" Bool :> Verb 'GET 200 '[JSON] PersistentTopicInternalStats

data PersistentTopicsGetInternalStatsParameters = PersistentTopicsGetInternalStatsParameters
  { persistentTopicsGetInternalStatsTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetInternalStatsNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetInternalStatsTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetInternalStatsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsGetInternalStatsMetadata :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsGetInternalStats :: PersistentTopicsGetInternalStatsParameters -> ClientM PersistentTopicInternalStats
persistentTopicsGetInternalStats PersistentTopicsGetInternalStatsParameters {..} = client (Proxy :: Proxy PersistentTopicsGetInternalStatsAPI) (persistentTopicsGetInternalStatsTenant) (persistentTopicsGetInternalStatsNamespace) (persistentTopicsGetInternalStatsTopic) (persistentTopicsGetInternalStatsAuthoritative) (persistentTopicsGetInternalStatsMetadata)

-- ^ 
type PersistentTopicsGetLastMessageIdAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "lastMessageId" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] MessageIdAdv

data PersistentTopicsGetLastMessageIdParameters = PersistentTopicsGetLastMessageIdParameters
  { persistentTopicsGetLastMessageIdTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetLastMessageIdNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetLastMessageIdTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetLastMessageIdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetLastMessageId :: PersistentTopicsGetLastMessageIdParameters -> ClientM MessageIdAdv
persistentTopicsGetLastMessageId PersistentTopicsGetLastMessageIdParameters {..} = client (Proxy :: Proxy PersistentTopicsGetLastMessageIdAPI) (persistentTopicsGetLastMessageIdTenant) (persistentTopicsGetLastMessageIdNamespace) (persistentTopicsGetLastMessageIdTopic) (persistentTopicsGetLastMessageIdAuthoritative)

-- ^ 
type PersistentTopicsGetListAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> QueryParam "bundle" Text :> QueryParam "includeSystemTopic" Bool :> Verb 'GET 200 '[JSON] [Text]

data PersistentTopicsGetListParameters = PersistentTopicsGetListParameters
  { persistentTopicsGetListTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetListNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetListBundle :: Maybe Text -- ^ Specify the bundle name
  , persistentTopicsGetListIncludeSystemTopic :: Maybe Bool -- ^ Include system topic
  } deriving (Show, Eq, Generic)

persistentTopicsGetList :: PersistentTopicsGetListParameters -> ClientM [Text]
persistentTopicsGetList PersistentTopicsGetListParameters {..} = client (Proxy :: Proxy PersistentTopicsGetListAPI) (persistentTopicsGetListTenant) (persistentTopicsGetListNamespace) (persistentTopicsGetListBundle) (persistentTopicsGetListIncludeSystemTopic)

-- ^ 
type PersistentTopicsGetManagedLedgerInfoAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "internal-info" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PartitionedManagedLedgerInfo

data PersistentTopicsGetManagedLedgerInfoParameters = PersistentTopicsGetManagedLedgerInfoParameters
  { persistentTopicsGetManagedLedgerInfoTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetManagedLedgerInfoNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetManagedLedgerInfoTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetManagedLedgerInfoAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetManagedLedgerInfo :: PersistentTopicsGetManagedLedgerInfoParameters -> ClientM PartitionedManagedLedgerInfo
persistentTopicsGetManagedLedgerInfo PersistentTopicsGetManagedLedgerInfoParameters {..} = client (Proxy :: Proxy PersistentTopicsGetManagedLedgerInfoAPI) (persistentTopicsGetManagedLedgerInfoTenant) (persistentTopicsGetManagedLedgerInfoNamespace) (persistentTopicsGetManagedLedgerInfoTopic) (persistentTopicsGetManagedLedgerInfoAuthoritative)

-- ^ 
type PersistentTopicsGetMaxConsumersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumers" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetMaxConsumersParameters = PersistentTopicsGetMaxConsumersParameters
  { persistentTopicsGetMaxConsumersTenant :: Text -- ^ 
  , persistentTopicsGetMaxConsumersNamespace :: Text -- ^ 
  , persistentTopicsGetMaxConsumersTopic :: Text -- ^ 
  , persistentTopicsGetMaxConsumersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxConsumersApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxConsumersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMaxConsumers :: PersistentTopicsGetMaxConsumersParameters -> ClientM Int
persistentTopicsGetMaxConsumers PersistentTopicsGetMaxConsumersParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMaxConsumersAPI) (persistentTopicsGetMaxConsumersTenant) (persistentTopicsGetMaxConsumersNamespace) (persistentTopicsGetMaxConsumersTopic) (persistentTopicsGetMaxConsumersIsGlobal) (persistentTopicsGetMaxConsumersApplied) (persistentTopicsGetMaxConsumersAuthoritative)

-- ^ 
type PersistentTopicsGetMaxConsumersPerSubscriptionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumersPerSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetMaxConsumersPerSubscriptionParameters = PersistentTopicsGetMaxConsumersPerSubscriptionParameters
  { persistentTopicsGetMaxConsumersPerSubscriptionTenant :: Text -- ^ 
  , persistentTopicsGetMaxConsumersPerSubscriptionNamespace :: Text -- ^ 
  , persistentTopicsGetMaxConsumersPerSubscriptionTopic :: Text -- ^ 
  , persistentTopicsGetMaxConsumersPerSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxConsumersPerSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMaxConsumersPerSubscription :: PersistentTopicsGetMaxConsumersPerSubscriptionParameters -> ClientM Int
persistentTopicsGetMaxConsumersPerSubscription PersistentTopicsGetMaxConsumersPerSubscriptionParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMaxConsumersPerSubscriptionAPI) (persistentTopicsGetMaxConsumersPerSubscriptionTenant) (persistentTopicsGetMaxConsumersPerSubscriptionNamespace) (persistentTopicsGetMaxConsumersPerSubscriptionTopic) (persistentTopicsGetMaxConsumersPerSubscriptionIsGlobal) (persistentTopicsGetMaxConsumersPerSubscriptionAuthoritative)

-- ^ 
type PersistentTopicsGetMaxMessageSizeAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxMessageSize" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetMaxMessageSizeParameters = PersistentTopicsGetMaxMessageSizeParameters
  { persistentTopicsGetMaxMessageSizeTenant :: Text -- ^ 
  , persistentTopicsGetMaxMessageSizeNamespace :: Text -- ^ 
  , persistentTopicsGetMaxMessageSizeTopic :: Text -- ^ 
  , persistentTopicsGetMaxMessageSizeIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxMessageSizeAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMaxMessageSize :: PersistentTopicsGetMaxMessageSizeParameters -> ClientM Int
persistentTopicsGetMaxMessageSize PersistentTopicsGetMaxMessageSizeParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMaxMessageSizeAPI) (persistentTopicsGetMaxMessageSizeTenant) (persistentTopicsGetMaxMessageSizeNamespace) (persistentTopicsGetMaxMessageSizeTopic) (persistentTopicsGetMaxMessageSizeIsGlobal) (persistentTopicsGetMaxMessageSizeAuthoritative)

-- ^ 
type PersistentTopicsGetMaxProducersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxProducers" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetMaxProducersParameters = PersistentTopicsGetMaxProducersParameters
  { persistentTopicsGetMaxProducersTenant :: Text -- ^ 
  , persistentTopicsGetMaxProducersNamespace :: Text -- ^ 
  , persistentTopicsGetMaxProducersTopic :: Text -- ^ 
  , persistentTopicsGetMaxProducersApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxProducersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxProducersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMaxProducers :: PersistentTopicsGetMaxProducersParameters -> ClientM Int
persistentTopicsGetMaxProducers PersistentTopicsGetMaxProducersParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMaxProducersAPI) (persistentTopicsGetMaxProducersTenant) (persistentTopicsGetMaxProducersNamespace) (persistentTopicsGetMaxProducersTopic) (persistentTopicsGetMaxProducersApplied) (persistentTopicsGetMaxProducersIsGlobal) (persistentTopicsGetMaxProducersAuthoritative)

-- ^ 
type PersistentTopicsGetMaxSubscriptionsPerTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxSubscriptionsPerTopic" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetMaxSubscriptionsPerTopicParameters = PersistentTopicsGetMaxSubscriptionsPerTopicParameters
  { persistentTopicsGetMaxSubscriptionsPerTopicTenant :: Text -- ^ 
  , persistentTopicsGetMaxSubscriptionsPerTopicNamespace :: Text -- ^ 
  , persistentTopicsGetMaxSubscriptionsPerTopicTopic :: Text -- ^ 
  , persistentTopicsGetMaxSubscriptionsPerTopicIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxSubscriptionsPerTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMaxSubscriptionsPerTopic :: PersistentTopicsGetMaxSubscriptionsPerTopicParameters -> ClientM Int
persistentTopicsGetMaxSubscriptionsPerTopic PersistentTopicsGetMaxSubscriptionsPerTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMaxSubscriptionsPerTopicAPI) (persistentTopicsGetMaxSubscriptionsPerTopicTenant) (persistentTopicsGetMaxSubscriptionsPerTopicNamespace) (persistentTopicsGetMaxSubscriptionsPerTopicTopic) (persistentTopicsGetMaxSubscriptionsPerTopicIsGlobal) (persistentTopicsGetMaxSubscriptionsPerTopicAuthoritative)

-- ^ 
type PersistentTopicsGetMaxUnackedMessagesOnConsumerAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnConsumer" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetMaxUnackedMessagesOnConsumerParameters = PersistentTopicsGetMaxUnackedMessagesOnConsumerParameters
  { persistentTopicsGetMaxUnackedMessagesOnConsumerTenant :: Text -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnConsumerNamespace :: Text -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnConsumerTopic :: Text -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnConsumerApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnConsumerIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnConsumerAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMaxUnackedMessagesOnConsumer :: PersistentTopicsGetMaxUnackedMessagesOnConsumerParameters -> ClientM Int
persistentTopicsGetMaxUnackedMessagesOnConsumer PersistentTopicsGetMaxUnackedMessagesOnConsumerParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMaxUnackedMessagesOnConsumerAPI) (persistentTopicsGetMaxUnackedMessagesOnConsumerTenant) (persistentTopicsGetMaxUnackedMessagesOnConsumerNamespace) (persistentTopicsGetMaxUnackedMessagesOnConsumerTopic) (persistentTopicsGetMaxUnackedMessagesOnConsumerApplied) (persistentTopicsGetMaxUnackedMessagesOnConsumerIsGlobal) (persistentTopicsGetMaxUnackedMessagesOnConsumerAuthoritative)

-- ^ 
type PersistentTopicsGetMaxUnackedMessagesOnSubscriptionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnSubscription" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters = PersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters
  { persistentTopicsGetMaxUnackedMessagesOnSubscriptionTenant :: Text -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnSubscriptionNamespace :: Text -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnSubscriptionTopic :: Text -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnSubscriptionApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetMaxUnackedMessagesOnSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMaxUnackedMessagesOnSubscription :: PersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters -> ClientM Int
persistentTopicsGetMaxUnackedMessagesOnSubscription PersistentTopicsGetMaxUnackedMessagesOnSubscriptionParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMaxUnackedMessagesOnSubscriptionAPI) (persistentTopicsGetMaxUnackedMessagesOnSubscriptionTenant) (persistentTopicsGetMaxUnackedMessagesOnSubscriptionNamespace) (persistentTopicsGetMaxUnackedMessagesOnSubscriptionTopic) (persistentTopicsGetMaxUnackedMessagesOnSubscriptionApplied) (persistentTopicsGetMaxUnackedMessagesOnSubscriptionIsGlobal) (persistentTopicsGetMaxUnackedMessagesOnSubscriptionAuthoritative)

-- ^ 
type PersistentTopicsGetMessageByIdAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "ledger" :> Capture "ledgerId" Integer :> "entry" :> Capture "entryId" Integer :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] NoContent

data PersistentTopicsGetMessageByIdParameters = PersistentTopicsGetMessageByIdParameters
  { persistentTopicsGetMessageByIdTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetMessageByIdNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetMessageByIdTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetMessageByIdLedgerId :: Integer -- ^ The ledger id
  , persistentTopicsGetMessageByIdEntryId :: Integer -- ^ The entry id
  , persistentTopicsGetMessageByIdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMessageById :: PersistentTopicsGetMessageByIdParameters -> ClientM NoContent
persistentTopicsGetMessageById PersistentTopicsGetMessageByIdParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMessageByIdAPI) (persistentTopicsGetMessageByIdTenant) (persistentTopicsGetMessageByIdNamespace) (persistentTopicsGetMessageByIdTopic) (persistentTopicsGetMessageByIdLedgerId) (persistentTopicsGetMessageByIdEntryId) (persistentTopicsGetMessageByIdAuthoritative)

-- ^ 
type PersistentTopicsGetMessageIdByTimestampAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "messageid" :> Capture "timestamp" Integer :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] MessageIdAdv

data PersistentTopicsGetMessageIdByTimestampParameters = PersistentTopicsGetMessageIdByTimestampParameters
  { persistentTopicsGetMessageIdByTimestampTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetMessageIdByTimestampNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetMessageIdByTimestampTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetMessageIdByTimestampTimestamp :: Integer -- ^ Specify the timestamp
  , persistentTopicsGetMessageIdByTimestampAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMessageIdByTimestamp :: PersistentTopicsGetMessageIdByTimestampParameters -> ClientM MessageIdAdv
persistentTopicsGetMessageIdByTimestamp PersistentTopicsGetMessageIdByTimestampParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMessageIdByTimestampAPI) (persistentTopicsGetMessageIdByTimestampTenant) (persistentTopicsGetMessageIdByTimestampNamespace) (persistentTopicsGetMessageIdByTimestampTopic) (persistentTopicsGetMessageIdByTimestampTimestamp) (persistentTopicsGetMessageIdByTimestampAuthoritative)

-- ^ 
type PersistentTopicsGetMessageTTLAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "messageTTL" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Int

data PersistentTopicsGetMessageTTLParameters = PersistentTopicsGetMessageTTLParameters
  { persistentTopicsGetMessageTTLTenant :: Text -- ^ 
  , persistentTopicsGetMessageTTLNamespace :: Text -- ^ 
  , persistentTopicsGetMessageTTLTopic :: Text -- ^ 
  , persistentTopicsGetMessageTTLApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetMessageTTLIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetMessageTTLAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetMessageTTL :: PersistentTopicsGetMessageTTLParameters -> ClientM Int
persistentTopicsGetMessageTTL PersistentTopicsGetMessageTTLParameters {..} = client (Proxy :: Proxy PersistentTopicsGetMessageTTLAPI) (persistentTopicsGetMessageTTLTenant) (persistentTopicsGetMessageTTLNamespace) (persistentTopicsGetMessageTTLTopic) (persistentTopicsGetMessageTTLApplied) (persistentTopicsGetMessageTTLIsGlobal) (persistentTopicsGetMessageTTLAuthoritative)

-- ^ 
type PersistentTopicsGetOffloadPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offloadPolicies" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] OffloadPoliciesImpl

data PersistentTopicsGetOffloadPoliciesParameters = PersistentTopicsGetOffloadPoliciesParameters
  { persistentTopicsGetOffloadPoliciesTenant :: Text -- ^ 
  , persistentTopicsGetOffloadPoliciesNamespace :: Text -- ^ 
  , persistentTopicsGetOffloadPoliciesTopic :: Text -- ^ 
  , persistentTopicsGetOffloadPoliciesApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetOffloadPoliciesIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetOffloadPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetOffloadPolicies :: PersistentTopicsGetOffloadPoliciesParameters -> ClientM OffloadPoliciesImpl
persistentTopicsGetOffloadPolicies PersistentTopicsGetOffloadPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsGetOffloadPoliciesAPI) (persistentTopicsGetOffloadPoliciesTenant) (persistentTopicsGetOffloadPoliciesNamespace) (persistentTopicsGetOffloadPoliciesTopic) (persistentTopicsGetOffloadPoliciesApplied) (persistentTopicsGetOffloadPoliciesIsGlobal) (persistentTopicsGetOffloadPoliciesAuthoritative)

-- ^ 
type PersistentTopicsGetPartitionedMetadataAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitions" :> QueryParam "authoritative" Bool :> QueryParam "checkAllowAutoCreation" Bool :> Verb 'GET 200 '[JSON] PartitionedTopicMetadata

data PersistentTopicsGetPartitionedMetadataParameters = PersistentTopicsGetPartitionedMetadataParameters
  { persistentTopicsGetPartitionedMetadataTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetPartitionedMetadataNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetPartitionedMetadataTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetPartitionedMetadataAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsGetPartitionedMetadataCheckAllowAutoCreation :: Maybe Bool -- ^ Is check configuration required to automatically create topic
  } deriving (Show, Eq, Generic)

persistentTopicsGetPartitionedMetadata :: PersistentTopicsGetPartitionedMetadataParameters -> ClientM PartitionedTopicMetadata
persistentTopicsGetPartitionedMetadata PersistentTopicsGetPartitionedMetadataParameters {..} = client (Proxy :: Proxy PersistentTopicsGetPartitionedMetadataAPI) (persistentTopicsGetPartitionedMetadataTenant) (persistentTopicsGetPartitionedMetadataNamespace) (persistentTopicsGetPartitionedMetadataTopic) (persistentTopicsGetPartitionedMetadataAuthoritative) (persistentTopicsGetPartitionedMetadataCheckAllowAutoCreation)

-- ^ 
type PersistentTopicsGetPartitionedStatsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitioned-stats" :> QueryParam "perPartition" Bool :> QueryParam "authoritative" Bool :> QueryParam "getPreciseBacklog" Bool :> QueryParam "subscriptionBacklogSize" Bool :> QueryParam "getEarliestTimeInBacklog" Bool :> QueryParam "excludePublishers" Bool :> QueryParam "excludeConsumers" Bool :> Verb 'GET 200 '[JSON] PartitionedTopicStatsImpl

data PersistentTopicsGetPartitionedStatsParameters = PersistentTopicsGetPartitionedStatsParameters
  { persistentTopicsGetPartitionedStatsTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetPartitionedStatsNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetPartitionedStatsTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetPartitionedStatsPerPartition :: Maybe Bool -- ^ Get per partition stats
  , persistentTopicsGetPartitionedStatsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsGetPartitionedStatsGetPreciseBacklog :: Maybe Bool -- ^ If return precise backlog or imprecise backlog
  , persistentTopicsGetPartitionedStatsSubscriptionBacklogSize :: Maybe Bool -- ^ If return backlog size for each subscription, require locking on ledger so be careful not to use when there's heavy traffic.
  , persistentTopicsGetPartitionedStatsGetEarliestTimeInBacklog :: Maybe Bool -- ^ If return the earliest time in backlog
  , persistentTopicsGetPartitionedStatsExcludePublishers :: Maybe Bool -- ^ If exclude the publishers
  , persistentTopicsGetPartitionedStatsExcludeConsumers :: Maybe Bool -- ^ If exclude the consumers
  } deriving (Show, Eq, Generic)

persistentTopicsGetPartitionedStats :: PersistentTopicsGetPartitionedStatsParameters -> ClientM PartitionedTopicStatsImpl
persistentTopicsGetPartitionedStats PersistentTopicsGetPartitionedStatsParameters {..} = client (Proxy :: Proxy PersistentTopicsGetPartitionedStatsAPI) (persistentTopicsGetPartitionedStatsTenant) (persistentTopicsGetPartitionedStatsNamespace) (persistentTopicsGetPartitionedStatsTopic) (persistentTopicsGetPartitionedStatsPerPartition) (persistentTopicsGetPartitionedStatsAuthoritative) (persistentTopicsGetPartitionedStatsGetPreciseBacklog) (persistentTopicsGetPartitionedStatsSubscriptionBacklogSize) (persistentTopicsGetPartitionedStatsGetEarliestTimeInBacklog) (persistentTopicsGetPartitionedStatsExcludePublishers) (persistentTopicsGetPartitionedStatsExcludeConsumers)

-- ^ 
type PersistentTopicsGetPartitionedStatsInternalAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitioned-internalStats" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PartitionedTopicInternalStats

data PersistentTopicsGetPartitionedStatsInternalParameters = PersistentTopicsGetPartitionedStatsInternalParameters
  { persistentTopicsGetPartitionedStatsInternalTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetPartitionedStatsInternalNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetPartitionedStatsInternalTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetPartitionedStatsInternalAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetPartitionedStatsInternal :: PersistentTopicsGetPartitionedStatsInternalParameters -> ClientM PartitionedTopicInternalStats
persistentTopicsGetPartitionedStatsInternal PersistentTopicsGetPartitionedStatsInternalParameters {..} = client (Proxy :: Proxy PersistentTopicsGetPartitionedStatsInternalAPI) (persistentTopicsGetPartitionedStatsInternalTenant) (persistentTopicsGetPartitionedStatsInternalNamespace) (persistentTopicsGetPartitionedStatsInternalTopic) (persistentTopicsGetPartitionedStatsInternalAuthoritative)

-- ^ 
type PersistentTopicsGetPartitionedTopicListAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> "partitioned" :> QueryParam "includeSystemTopic" Bool :> Verb 'GET 200 '[JSON] [Text]

data PersistentTopicsGetPartitionedTopicListParameters = PersistentTopicsGetPartitionedTopicListParameters
  { persistentTopicsGetPartitionedTopicListTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetPartitionedTopicListNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetPartitionedTopicListIncludeSystemTopic :: Maybe Bool -- ^ Include system topic
  } deriving (Show, Eq, Generic)

persistentTopicsGetPartitionedTopicList :: PersistentTopicsGetPartitionedTopicListParameters -> ClientM [Text]
persistentTopicsGetPartitionedTopicList PersistentTopicsGetPartitionedTopicListParameters {..} = client (Proxy :: Proxy PersistentTopicsGetPartitionedTopicListAPI) (persistentTopicsGetPartitionedTopicListTenant) (persistentTopicsGetPartitionedTopicListNamespace) (persistentTopicsGetPartitionedTopicListIncludeSystemTopic)

-- ^ Retrieve the effective permissions for a topic. These permissions are defined by the permissions set at thenamespace level combined (union) with any eventual specific permission set on the topic.Returns a nested map structure which Swagger does not fully support for display. Structure: Map<String, Set<AuthAction>>. Please refer to this structure for details.
type PersistentTopicsGetPermissionsOnTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "permissions" :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

data PersistentTopicsGetPermissionsOnTopicParameters = PersistentTopicsGetPermissionsOnTopicParameters
  { persistentTopicsGetPermissionsOnTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetPermissionsOnTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetPermissionsOnTopicTopic :: Text -- ^ Specify topic name
  } deriving (Show, Eq, Generic)

persistentTopicsGetPermissionsOnTopic :: PersistentTopicsGetPermissionsOnTopicParameters -> ClientM (Map.Map String Text)
persistentTopicsGetPermissionsOnTopic PersistentTopicsGetPermissionsOnTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsGetPermissionsOnTopicAPI) (persistentTopicsGetPermissionsOnTopicTenant) (persistentTopicsGetPermissionsOnTopicNamespace) (persistentTopicsGetPermissionsOnTopicTopic)

-- ^ 
type PersistentTopicsGetPersistenceAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "persistence" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PersistencePolicies

data PersistentTopicsGetPersistenceParameters = PersistentTopicsGetPersistenceParameters
  { persistentTopicsGetPersistenceTenant :: Text -- ^ 
  , persistentTopicsGetPersistenceNamespace :: Text -- ^ 
  , persistentTopicsGetPersistenceTopic :: Text -- ^ 
  , persistentTopicsGetPersistenceApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetPersistenceIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetPersistenceAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetPersistence :: PersistentTopicsGetPersistenceParameters -> ClientM PersistencePolicies
persistentTopicsGetPersistence PersistentTopicsGetPersistenceParameters {..} = client (Proxy :: Proxy PersistentTopicsGetPersistenceAPI) (persistentTopicsGetPersistenceTenant) (persistentTopicsGetPersistenceNamespace) (persistentTopicsGetPersistenceTopic) (persistentTopicsGetPersistenceApplied) (persistentTopicsGetPersistenceIsGlobal) (persistentTopicsGetPersistenceAuthoritative)

-- ^ 
type PersistentTopicsGetPropertiesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "properties" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

data PersistentTopicsGetPropertiesParameters = PersistentTopicsGetPropertiesParameters
  { persistentTopicsGetPropertiesTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetPropertiesNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetPropertiesTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetPropertiesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetProperties :: PersistentTopicsGetPropertiesParameters -> ClientM (Map.Map String Text)
persistentTopicsGetProperties PersistentTopicsGetPropertiesParameters {..} = client (Proxy :: Proxy PersistentTopicsGetPropertiesAPI) (persistentTopicsGetPropertiesTenant) (persistentTopicsGetPropertiesNamespace) (persistentTopicsGetPropertiesTopic) (persistentTopicsGetPropertiesAuthoritative)

-- ^ 
type PersistentTopicsGetPublishRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "publishRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] PublishRate

data PersistentTopicsGetPublishRateParameters = PersistentTopicsGetPublishRateParameters
  { persistentTopicsGetPublishRateTenant :: Text -- ^ 
  , persistentTopicsGetPublishRateNamespace :: Text -- ^ 
  , persistentTopicsGetPublishRateTopic :: Text -- ^ 
  , persistentTopicsGetPublishRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetPublishRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetPublishRate :: PersistentTopicsGetPublishRateParameters -> ClientM PublishRate
persistentTopicsGetPublishRate PersistentTopicsGetPublishRateParameters {..} = client (Proxy :: Proxy PersistentTopicsGetPublishRateAPI) (persistentTopicsGetPublishRateTenant) (persistentTopicsGetPublishRateNamespace) (persistentTopicsGetPublishRateTopic) (persistentTopicsGetPublishRateIsGlobal) (persistentTopicsGetPublishRateAuthoritative)

-- ^ 
type PersistentTopicsGetReplicatedSubscriptionStatusAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "replicatedSubscriptionStatus" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] ((Map.Map String Bool))

data PersistentTopicsGetReplicatedSubscriptionStatusParameters = PersistentTopicsGetReplicatedSubscriptionStatusParameters
  { persistentTopicsGetReplicatedSubscriptionStatusTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetReplicatedSubscriptionStatusNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetReplicatedSubscriptionStatusTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetReplicatedSubscriptionStatusSubName :: Text -- ^ Name of subscription
  , persistentTopicsGetReplicatedSubscriptionStatusAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetReplicatedSubscriptionStatus :: PersistentTopicsGetReplicatedSubscriptionStatusParameters -> ClientM (Map.Map String Bool)
persistentTopicsGetReplicatedSubscriptionStatus PersistentTopicsGetReplicatedSubscriptionStatusParameters {..} = client (Proxy :: Proxy PersistentTopicsGetReplicatedSubscriptionStatusAPI) (persistentTopicsGetReplicatedSubscriptionStatusTenant) (persistentTopicsGetReplicatedSubscriptionStatusNamespace) (persistentTopicsGetReplicatedSubscriptionStatusTopic) (persistentTopicsGetReplicatedSubscriptionStatusSubName) (persistentTopicsGetReplicatedSubscriptionStatusAuthoritative)

-- ^ 
type PersistentTopicsGetReplicationClustersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replication" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] [Text]

data PersistentTopicsGetReplicationClustersParameters = PersistentTopicsGetReplicationClustersParameters
  { persistentTopicsGetReplicationClustersTenant :: Text -- ^ 
  , persistentTopicsGetReplicationClustersNamespace :: Text -- ^ 
  , persistentTopicsGetReplicationClustersTopic :: Text -- ^ 
  , persistentTopicsGetReplicationClustersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetReplicationClustersApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetReplicationClustersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetReplicationClusters :: PersistentTopicsGetReplicationClustersParameters -> ClientM [Text]
persistentTopicsGetReplicationClusters PersistentTopicsGetReplicationClustersParameters {..} = client (Proxy :: Proxy PersistentTopicsGetReplicationClustersAPI) (persistentTopicsGetReplicationClustersTenant) (persistentTopicsGetReplicationClustersNamespace) (persistentTopicsGetReplicationClustersTopic) (persistentTopicsGetReplicationClustersIsGlobal) (persistentTopicsGetReplicationClustersApplied) (persistentTopicsGetReplicationClustersAuthoritative)

-- ^ 
type PersistentTopicsGetReplicatorDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replicatorDispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DispatchRate

data PersistentTopicsGetReplicatorDispatchRateParameters = PersistentTopicsGetReplicatorDispatchRateParameters
  { persistentTopicsGetReplicatorDispatchRateTenant :: Text -- ^ 
  , persistentTopicsGetReplicatorDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsGetReplicatorDispatchRateTopic :: Text -- ^ 
  , persistentTopicsGetReplicatorDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetReplicatorDispatchRateApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetReplicatorDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetReplicatorDispatchRate :: PersistentTopicsGetReplicatorDispatchRateParameters -> ClientM DispatchRate
persistentTopicsGetReplicatorDispatchRate PersistentTopicsGetReplicatorDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsGetReplicatorDispatchRateAPI) (persistentTopicsGetReplicatorDispatchRateTenant) (persistentTopicsGetReplicatorDispatchRateNamespace) (persistentTopicsGetReplicatorDispatchRateTopic) (persistentTopicsGetReplicatorDispatchRateIsGlobal) (persistentTopicsGetReplicatorDispatchRateApplied) (persistentTopicsGetReplicatorDispatchRateAuthoritative)

-- ^ 
type PersistentTopicsGetRetentionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "retention" :> QueryParam "isGlobal" Bool :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] RetentionPolicies

data PersistentTopicsGetRetentionParameters = PersistentTopicsGetRetentionParameters
  { persistentTopicsGetRetentionTenant :: Text -- ^ 
  , persistentTopicsGetRetentionNamespace :: Text -- ^ 
  , persistentTopicsGetRetentionTopic :: Text -- ^ 
  , persistentTopicsGetRetentionIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetRetentionApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetRetentionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetRetention :: PersistentTopicsGetRetentionParameters -> ClientM RetentionPolicies
persistentTopicsGetRetention PersistentTopicsGetRetentionParameters {..} = client (Proxy :: Proxy PersistentTopicsGetRetentionAPI) (persistentTopicsGetRetentionTenant) (persistentTopicsGetRetentionNamespace) (persistentTopicsGetRetentionTopic) (persistentTopicsGetRetentionIsGlobal) (persistentTopicsGetRetentionApplied) (persistentTopicsGetRetentionAuthoritative)

-- ^ 
type PersistentTopicsGetSchemaCompatibilityStrategyAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaCompatibilityStrategy" :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Text

data PersistentTopicsGetSchemaCompatibilityStrategyParameters = PersistentTopicsGetSchemaCompatibilityStrategyParameters
  { persistentTopicsGetSchemaCompatibilityStrategyTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetSchemaCompatibilityStrategyNamespace :: Text -- ^ Specify the cluster
  , persistentTopicsGetSchemaCompatibilityStrategyTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetSchemaCompatibilityStrategyApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetSchemaCompatibilityStrategyAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetSchemaCompatibilityStrategy :: PersistentTopicsGetSchemaCompatibilityStrategyParameters -> ClientM Text
persistentTopicsGetSchemaCompatibilityStrategy PersistentTopicsGetSchemaCompatibilityStrategyParameters {..} = client (Proxy :: Proxy PersistentTopicsGetSchemaCompatibilityStrategyAPI) (persistentTopicsGetSchemaCompatibilityStrategyTenant) (persistentTopicsGetSchemaCompatibilityStrategyNamespace) (persistentTopicsGetSchemaCompatibilityStrategyTopic) (persistentTopicsGetSchemaCompatibilityStrategyApplied) (persistentTopicsGetSchemaCompatibilityStrategyAuthoritative)

-- ^ 
type PersistentTopicsGetSchemaValidationEnforcedAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaValidationEnforced" :> QueryParam "applied" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] Bool

data PersistentTopicsGetSchemaValidationEnforcedParameters = PersistentTopicsGetSchemaValidationEnforcedParameters
  { persistentTopicsGetSchemaValidationEnforcedTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetSchemaValidationEnforcedNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetSchemaValidationEnforcedTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetSchemaValidationEnforcedApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetSchemaValidationEnforcedAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetSchemaValidationEnforced :: PersistentTopicsGetSchemaValidationEnforcedParameters -> ClientM Bool
persistentTopicsGetSchemaValidationEnforced PersistentTopicsGetSchemaValidationEnforcedParameters {..} = client (Proxy :: Proxy PersistentTopicsGetSchemaValidationEnforcedAPI) (persistentTopicsGetSchemaValidationEnforcedTenant) (persistentTopicsGetSchemaValidationEnforcedNamespace) (persistentTopicsGetSchemaValidationEnforcedTopic) (persistentTopicsGetSchemaValidationEnforcedApplied) (persistentTopicsGetSchemaValidationEnforcedAuthoritative)

-- ^ 
type PersistentTopicsGetShadowTopicsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "shadowTopics" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] [Text]

data PersistentTopicsGetShadowTopicsParameters = PersistentTopicsGetShadowTopicsParameters
  { persistentTopicsGetShadowTopicsTenant :: Text -- ^ 
  , persistentTopicsGetShadowTopicsNamespace :: Text -- ^ 
  , persistentTopicsGetShadowTopicsTopic :: Text -- ^ 
  , persistentTopicsGetShadowTopicsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetShadowTopics :: PersistentTopicsGetShadowTopicsParameters -> ClientM [Text]
persistentTopicsGetShadowTopics PersistentTopicsGetShadowTopicsParameters {..} = client (Proxy :: Proxy PersistentTopicsGetShadowTopicsAPI) (persistentTopicsGetShadowTopicsTenant) (persistentTopicsGetShadowTopicsNamespace) (persistentTopicsGetShadowTopicsTopic) (persistentTopicsGetShadowTopicsAuthoritative)

-- ^ 
type PersistentTopicsGetStatsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "stats" :> QueryParam "authoritative" Bool :> QueryParam "getPreciseBacklog" Bool :> QueryParam "subscriptionBacklogSize" Bool :> QueryParam "getEarliestTimeInBacklog" Bool :> QueryParam "excludePublishers" Bool :> QueryParam "excludeConsumers" Bool :> Verb 'GET 200 '[JSON] PersistentTopicStats

data PersistentTopicsGetStatsParameters = PersistentTopicsGetStatsParameters
  { persistentTopicsGetStatsTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetStatsNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetStatsTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetStatsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsGetStatsGetPreciseBacklog :: Maybe Bool -- ^ If return precise backlog or imprecise backlog
  , persistentTopicsGetStatsSubscriptionBacklogSize :: Maybe Bool -- ^ If return backlog size for each subscription, require locking on ledger so be careful not to use when there's heavy traffic.
  , persistentTopicsGetStatsGetEarliestTimeInBacklog :: Maybe Bool -- ^ If return time of the earliest message in backlog
  , persistentTopicsGetStatsExcludePublishers :: Maybe Bool -- ^ If exclude the publishers
  , persistentTopicsGetStatsExcludeConsumers :: Maybe Bool -- ^ If exclude the consumers
  } deriving (Show, Eq, Generic)

persistentTopicsGetStats :: PersistentTopicsGetStatsParameters -> ClientM PersistentTopicStats
persistentTopicsGetStats PersistentTopicsGetStatsParameters {..} = client (Proxy :: Proxy PersistentTopicsGetStatsAPI) (persistentTopicsGetStatsTenant) (persistentTopicsGetStatsNamespace) (persistentTopicsGetStatsTopic) (persistentTopicsGetStatsAuthoritative) (persistentTopicsGetStatsGetPreciseBacklog) (persistentTopicsGetStatsSubscriptionBacklogSize) (persistentTopicsGetStatsGetEarliestTimeInBacklog) (persistentTopicsGetStatsExcludePublishers) (persistentTopicsGetStatsExcludeConsumers)

-- ^ 
type PersistentTopicsGetSubscribeRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscribeRate" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] SubscribeRate

data PersistentTopicsGetSubscribeRateParameters = PersistentTopicsGetSubscribeRateParameters
  { persistentTopicsGetSubscribeRateTenant :: Text -- ^ 
  , persistentTopicsGetSubscribeRateNamespace :: Text -- ^ 
  , persistentTopicsGetSubscribeRateTopic :: Text -- ^ 
  , persistentTopicsGetSubscribeRateApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetSubscribeRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetSubscribeRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetSubscribeRate :: PersistentTopicsGetSubscribeRateParameters -> ClientM SubscribeRate
persistentTopicsGetSubscribeRate PersistentTopicsGetSubscribeRateParameters {..} = client (Proxy :: Proxy PersistentTopicsGetSubscribeRateAPI) (persistentTopicsGetSubscribeRateTenant) (persistentTopicsGetSubscribeRateNamespace) (persistentTopicsGetSubscribeRateTopic) (persistentTopicsGetSubscribeRateApplied) (persistentTopicsGetSubscribeRateIsGlobal) (persistentTopicsGetSubscribeRateAuthoritative)

-- ^ 
type PersistentTopicsGetSubscriptionDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionDispatchRate" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DispatchRate

data PersistentTopicsGetSubscriptionDispatchRateParameters = PersistentTopicsGetSubscriptionDispatchRateParameters
  { persistentTopicsGetSubscriptionDispatchRateTenant :: Text -- ^ 
  , persistentTopicsGetSubscriptionDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsGetSubscriptionDispatchRateTopic :: Text -- ^ 
  , persistentTopicsGetSubscriptionDispatchRateApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetSubscriptionDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetSubscriptionDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetSubscriptionDispatchRate :: PersistentTopicsGetSubscriptionDispatchRateParameters -> ClientM DispatchRate
persistentTopicsGetSubscriptionDispatchRate PersistentTopicsGetSubscriptionDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsGetSubscriptionDispatchRateAPI) (persistentTopicsGetSubscriptionDispatchRateTenant) (persistentTopicsGetSubscriptionDispatchRateNamespace) (persistentTopicsGetSubscriptionDispatchRateTopic) (persistentTopicsGetSubscriptionDispatchRateApplied) (persistentTopicsGetSubscriptionDispatchRateIsGlobal) (persistentTopicsGetSubscriptionDispatchRateAuthoritative)

-- ^ 
type PersistentTopicsGetSubscriptionLevelDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> Capture "subName" Text :> "dispatchRate" :> QueryParam "applied" Bool :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] DispatchRate

data PersistentTopicsGetSubscriptionLevelDispatchRateParameters = PersistentTopicsGetSubscriptionLevelDispatchRateParameters
  { persistentTopicsGetSubscriptionLevelDispatchRateTenant :: Text -- ^ 
  , persistentTopicsGetSubscriptionLevelDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsGetSubscriptionLevelDispatchRateTopic :: Text -- ^ 
  , persistentTopicsGetSubscriptionLevelDispatchRateSubName :: Text -- ^ 
  , persistentTopicsGetSubscriptionLevelDispatchRateApplied :: Maybe Bool -- ^ 
  , persistentTopicsGetSubscriptionLevelDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetSubscriptionLevelDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetSubscriptionLevelDispatchRate :: PersistentTopicsGetSubscriptionLevelDispatchRateParameters -> ClientM DispatchRate
persistentTopicsGetSubscriptionLevelDispatchRate PersistentTopicsGetSubscriptionLevelDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsGetSubscriptionLevelDispatchRateAPI) (persistentTopicsGetSubscriptionLevelDispatchRateTenant) (persistentTopicsGetSubscriptionLevelDispatchRateNamespace) (persistentTopicsGetSubscriptionLevelDispatchRateTopic) (persistentTopicsGetSubscriptionLevelDispatchRateSubName) (persistentTopicsGetSubscriptionLevelDispatchRateApplied) (persistentTopicsGetSubscriptionLevelDispatchRateIsGlobal) (persistentTopicsGetSubscriptionLevelDispatchRateAuthoritative)

-- ^ 
type PersistentTopicsGetSubscriptionPropertiesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "properties" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] ((Map.Map String Text))

data PersistentTopicsGetSubscriptionPropertiesParameters = PersistentTopicsGetSubscriptionPropertiesParameters
  { persistentTopicsGetSubscriptionPropertiesTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetSubscriptionPropertiesNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetSubscriptionPropertiesTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetSubscriptionPropertiesSubName :: Text -- ^ Subscription
  , persistentTopicsGetSubscriptionPropertiesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetSubscriptionProperties :: PersistentTopicsGetSubscriptionPropertiesParameters -> ClientM (Map.Map String Text)
persistentTopicsGetSubscriptionProperties PersistentTopicsGetSubscriptionPropertiesParameters {..} = client (Proxy :: Proxy PersistentTopicsGetSubscriptionPropertiesAPI) (persistentTopicsGetSubscriptionPropertiesTenant) (persistentTopicsGetSubscriptionPropertiesNamespace) (persistentTopicsGetSubscriptionPropertiesTopic) (persistentTopicsGetSubscriptionPropertiesSubName) (persistentTopicsGetSubscriptionPropertiesAuthoritative)

-- ^ 
type PersistentTopicsGetSubscriptionTypesEnabledAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionTypesEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] [Text]

data PersistentTopicsGetSubscriptionTypesEnabledParameters = PersistentTopicsGetSubscriptionTypesEnabledParameters
  { persistentTopicsGetSubscriptionTypesEnabledTenant :: Text -- ^ 
  , persistentTopicsGetSubscriptionTypesEnabledNamespace :: Text -- ^ 
  , persistentTopicsGetSubscriptionTypesEnabledTopic :: Text -- ^ 
  , persistentTopicsGetSubscriptionTypesEnabledIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsGetSubscriptionTypesEnabledAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetSubscriptionTypesEnabled :: PersistentTopicsGetSubscriptionTypesEnabledParameters -> ClientM [Text]
persistentTopicsGetSubscriptionTypesEnabled PersistentTopicsGetSubscriptionTypesEnabledParameters {..} = client (Proxy :: Proxy PersistentTopicsGetSubscriptionTypesEnabledAPI) (persistentTopicsGetSubscriptionTypesEnabledTenant) (persistentTopicsGetSubscriptionTypesEnabledNamespace) (persistentTopicsGetSubscriptionTypesEnabledTopic) (persistentTopicsGetSubscriptionTypesEnabledIsGlobal) (persistentTopicsGetSubscriptionTypesEnabledAuthoritative)

-- ^ 
type PersistentTopicsGetSubscriptionsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptions" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] [Text]

data PersistentTopicsGetSubscriptionsParameters = PersistentTopicsGetSubscriptionsParameters
  { persistentTopicsGetSubscriptionsTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGetSubscriptionsNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGetSubscriptionsTopic :: Text -- ^ Specify topic name
  , persistentTopicsGetSubscriptionsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsGetSubscriptions :: PersistentTopicsGetSubscriptionsParameters -> ClientM [Text]
persistentTopicsGetSubscriptions PersistentTopicsGetSubscriptionsParameters {..} = client (Proxy :: Proxy PersistentTopicsGetSubscriptionsAPI) (persistentTopicsGetSubscriptionsTenant) (persistentTopicsGetSubscriptionsNamespace) (persistentTopicsGetSubscriptionsTopic) (persistentTopicsGetSubscriptionsAuthoritative)

-- ^ 
type PersistentTopicsGrantPermissionsOnTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "permissions" :> Capture "role" Text :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsGrantPermissionsOnTopicParameters = PersistentTopicsGrantPermissionsOnTopicParameters
  { persistentTopicsGrantPermissionsOnTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsGrantPermissionsOnTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsGrantPermissionsOnTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsGrantPermissionsOnTopicRole :: Text -- ^ Client role to which grant permissions
  , persistentTopicsGrantPermissionsOnTopicBody :: [Text] -- ^ Actions to be granted (produce,functions,consume)
  } deriving (Show, Eq, Generic)

persistentTopicsGrantPermissionsOnTopic :: PersistentTopicsGrantPermissionsOnTopicParameters -> ClientM NoContent
persistentTopicsGrantPermissionsOnTopic PersistentTopicsGrantPermissionsOnTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsGrantPermissionsOnTopicAPI) (persistentTopicsGrantPermissionsOnTopicTenant) (persistentTopicsGrantPermissionsOnTopicNamespace) (persistentTopicsGrantPermissionsOnTopicTopic) (persistentTopicsGrantPermissionsOnTopicRole) persistentTopicsGrantPermissionsOnTopicBody

-- ^ 
type PersistentTopicsOffloadStatusAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offload" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] OffloadProcessStatus

data PersistentTopicsOffloadStatusParameters = PersistentTopicsOffloadStatusParameters
  { persistentTopicsOffloadStatusTenant :: Text -- ^ Specify the tenant
  , persistentTopicsOffloadStatusNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsOffloadStatusTopic :: Text -- ^ Specify topic name
  , persistentTopicsOffloadStatusAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsOffloadStatus :: PersistentTopicsOffloadStatusParameters -> ClientM OffloadProcessStatus
persistentTopicsOffloadStatus PersistentTopicsOffloadStatusParameters {..} = client (Proxy :: Proxy PersistentTopicsOffloadStatusAPI) (persistentTopicsOffloadStatusTenant) (persistentTopicsOffloadStatusNamespace) (persistentTopicsOffloadStatusTopic) (persistentTopicsOffloadStatusAuthoritative)

-- ^ 
type PersistentTopicsPeekNthMessageAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "position" :> Capture "messagePosition" Int :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] NoContent

data PersistentTopicsPeekNthMessageParameters = PersistentTopicsPeekNthMessageParameters
  { persistentTopicsPeekNthMessageTenant :: Text -- ^ Specify the tenant
  , persistentTopicsPeekNthMessageNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsPeekNthMessageTopic :: Text -- ^ Specify topic name
  , persistentTopicsPeekNthMessageSubName :: Text -- ^ Subscribed message expired
  , persistentTopicsPeekNthMessageMessagePosition :: Int -- ^ The number of messages (default 1)
  , persistentTopicsPeekNthMessageAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsPeekNthMessage :: PersistentTopicsPeekNthMessageParameters -> ClientM NoContent
persistentTopicsPeekNthMessage PersistentTopicsPeekNthMessageParameters {..} = client (Proxy :: Proxy PersistentTopicsPeekNthMessageAPI) (persistentTopicsPeekNthMessageTenant) (persistentTopicsPeekNthMessageNamespace) (persistentTopicsPeekNthMessageTopic) (persistentTopicsPeekNthMessageSubName) (persistentTopicsPeekNthMessageMessagePosition) (persistentTopicsPeekNthMessageAuthoritative)

-- ^ 
type PersistentTopicsRemoveAutoSubscriptionCreationAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "autoSubscriptionCreation" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveAutoSubscriptionCreationParameters = PersistentTopicsRemoveAutoSubscriptionCreationParameters
  { persistentTopicsRemoveAutoSubscriptionCreationTenant :: Text -- ^ 
  , persistentTopicsRemoveAutoSubscriptionCreationNamespace :: Text -- ^ 
  , persistentTopicsRemoveAutoSubscriptionCreationTopic :: Text -- ^ 
  , persistentTopicsRemoveAutoSubscriptionCreationIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveAutoSubscriptionCreationAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveAutoSubscriptionCreation :: PersistentTopicsRemoveAutoSubscriptionCreationParameters -> ClientM NoContent
persistentTopicsRemoveAutoSubscriptionCreation PersistentTopicsRemoveAutoSubscriptionCreationParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveAutoSubscriptionCreationAPI) (persistentTopicsRemoveAutoSubscriptionCreationTenant) (persistentTopicsRemoveAutoSubscriptionCreationNamespace) (persistentTopicsRemoveAutoSubscriptionCreationTopic) (persistentTopicsRemoveAutoSubscriptionCreationIsGlobal) (persistentTopicsRemoveAutoSubscriptionCreationAuthoritative)

-- ^ 
type PersistentTopicsRemoveBacklogQuotaAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlogQuota" :> QueryParam "backlogQuotaType" Text :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveBacklogQuotaParameters = PersistentTopicsRemoveBacklogQuotaParameters
  { persistentTopicsRemoveBacklogQuotaTenant :: Text -- ^ 
  , persistentTopicsRemoveBacklogQuotaNamespace :: Text -- ^ 
  , persistentTopicsRemoveBacklogQuotaTopic :: Text -- ^ 
  , persistentTopicsRemoveBacklogQuotaBacklogQuotaType :: Maybe Text -- ^ 
  , persistentTopicsRemoveBacklogQuotaAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsRemoveBacklogQuotaIsGlobal :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveBacklogQuota :: PersistentTopicsRemoveBacklogQuotaParameters -> ClientM NoContent
persistentTopicsRemoveBacklogQuota PersistentTopicsRemoveBacklogQuotaParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveBacklogQuotaAPI) (persistentTopicsRemoveBacklogQuotaTenant) (persistentTopicsRemoveBacklogQuotaNamespace) (persistentTopicsRemoveBacklogQuotaTopic) (persistentTopicsRemoveBacklogQuotaBacklogQuotaType) (persistentTopicsRemoveBacklogQuotaAuthoritative) (persistentTopicsRemoveBacklogQuotaIsGlobal)

-- ^ 
type PersistentTopicsRemoveCompactionThresholdAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compactionThreshold" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveCompactionThresholdParameters = PersistentTopicsRemoveCompactionThresholdParameters
  { persistentTopicsRemoveCompactionThresholdTenant :: Text -- ^ 
  , persistentTopicsRemoveCompactionThresholdNamespace :: Text -- ^ 
  , persistentTopicsRemoveCompactionThresholdTopic :: Text -- ^ 
  , persistentTopicsRemoveCompactionThresholdIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveCompactionThresholdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveCompactionThreshold :: PersistentTopicsRemoveCompactionThresholdParameters -> ClientM NoContent
persistentTopicsRemoveCompactionThreshold PersistentTopicsRemoveCompactionThresholdParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveCompactionThresholdAPI) (persistentTopicsRemoveCompactionThresholdTenant) (persistentTopicsRemoveCompactionThresholdNamespace) (persistentTopicsRemoveCompactionThresholdTopic) (persistentTopicsRemoveCompactionThresholdIsGlobal) (persistentTopicsRemoveCompactionThresholdAuthoritative)

-- ^ 
type PersistentTopicsRemoveDeduplicationAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveDeduplicationParameters = PersistentTopicsRemoveDeduplicationParameters
  { persistentTopicsRemoveDeduplicationTenant :: Text -- ^ 
  , persistentTopicsRemoveDeduplicationNamespace :: Text -- ^ 
  , persistentTopicsRemoveDeduplicationTopic :: Text -- ^ 
  , persistentTopicsRemoveDeduplicationIsGlobal :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsRemoveDeduplicationAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveDeduplication :: PersistentTopicsRemoveDeduplicationParameters -> ClientM NoContent
persistentTopicsRemoveDeduplication PersistentTopicsRemoveDeduplicationParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveDeduplicationAPI) (persistentTopicsRemoveDeduplicationTenant) (persistentTopicsRemoveDeduplicationNamespace) (persistentTopicsRemoveDeduplicationTopic) (persistentTopicsRemoveDeduplicationIsGlobal) (persistentTopicsRemoveDeduplicationAuthoritative)

-- ^ 
type PersistentTopicsRemoveDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveDispatchRateParameters = PersistentTopicsRemoveDispatchRateParameters
  { persistentTopicsRemoveDispatchRateTenant :: Text -- ^ 
  , persistentTopicsRemoveDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsRemoveDispatchRateTopic :: Text -- ^ 
  , persistentTopicsRemoveDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveDispatchRate :: PersistentTopicsRemoveDispatchRateParameters -> ClientM NoContent
persistentTopicsRemoveDispatchRate PersistentTopicsRemoveDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveDispatchRateAPI) (persistentTopicsRemoveDispatchRateTenant) (persistentTopicsRemoveDispatchRateNamespace) (persistentTopicsRemoveDispatchRateTopic) (persistentTopicsRemoveDispatchRateIsGlobal) (persistentTopicsRemoveDispatchRateAuthoritative)

-- ^ 
type PersistentTopicsRemoveDispatcherPauseOnAckStatePersistentAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatcherPauseOnAckStatePersistent" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters = PersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters
  { persistentTopicsRemoveDispatcherPauseOnAckStatePersistentTenant :: Text -- ^ 
  , persistentTopicsRemoveDispatcherPauseOnAckStatePersistentNamespace :: Text -- ^ 
  , persistentTopicsRemoveDispatcherPauseOnAckStatePersistentTopic :: Text -- ^ 
  , persistentTopicsRemoveDispatcherPauseOnAckStatePersistentIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveDispatcherPauseOnAckStatePersistentAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveDispatcherPauseOnAckStatePersistent :: PersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters -> ClientM NoContent
persistentTopicsRemoveDispatcherPauseOnAckStatePersistent PersistentTopicsRemoveDispatcherPauseOnAckStatePersistentParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveDispatcherPauseOnAckStatePersistentAPI) (persistentTopicsRemoveDispatcherPauseOnAckStatePersistentTenant) (persistentTopicsRemoveDispatcherPauseOnAckStatePersistentNamespace) (persistentTopicsRemoveDispatcherPauseOnAckStatePersistentTopic) (persistentTopicsRemoveDispatcherPauseOnAckStatePersistentIsGlobal) (persistentTopicsRemoveDispatcherPauseOnAckStatePersistentAuthoritative)

-- ^ 
type PersistentTopicsRemoveEntryFiltersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "entryFilters" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveEntryFiltersParameters = PersistentTopicsRemoveEntryFiltersParameters
  { persistentTopicsRemoveEntryFiltersTenant :: Text -- ^ 
  , persistentTopicsRemoveEntryFiltersNamespace :: Text -- ^ 
  , persistentTopicsRemoveEntryFiltersTopic :: Text -- ^ 
  , persistentTopicsRemoveEntryFiltersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveEntryFiltersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected thiscall to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveEntryFilters :: PersistentTopicsRemoveEntryFiltersParameters -> ClientM NoContent
persistentTopicsRemoveEntryFilters PersistentTopicsRemoveEntryFiltersParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveEntryFiltersAPI) (persistentTopicsRemoveEntryFiltersTenant) (persistentTopicsRemoveEntryFiltersNamespace) (persistentTopicsRemoveEntryFiltersTopic) (persistentTopicsRemoveEntryFiltersIsGlobal) (persistentTopicsRemoveEntryFiltersAuthoritative)

-- ^ 
type PersistentTopicsRemoveMaxConsumersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumers" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveMaxConsumersParameters = PersistentTopicsRemoveMaxConsumersParameters
  { persistentTopicsRemoveMaxConsumersTenant :: Text -- ^ 
  , persistentTopicsRemoveMaxConsumersNamespace :: Text -- ^ 
  , persistentTopicsRemoveMaxConsumersTopic :: Text -- ^ 
  , persistentTopicsRemoveMaxConsumersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveMaxConsumersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveMaxConsumers :: PersistentTopicsRemoveMaxConsumersParameters -> ClientM NoContent
persistentTopicsRemoveMaxConsumers PersistentTopicsRemoveMaxConsumersParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveMaxConsumersAPI) (persistentTopicsRemoveMaxConsumersTenant) (persistentTopicsRemoveMaxConsumersNamespace) (persistentTopicsRemoveMaxConsumersTopic) (persistentTopicsRemoveMaxConsumersIsGlobal) (persistentTopicsRemoveMaxConsumersAuthoritative)

-- ^ 
type PersistentTopicsRemoveMaxConsumersPerSubscriptionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumersPerSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveMaxConsumersPerSubscriptionParameters = PersistentTopicsRemoveMaxConsumersPerSubscriptionParameters
  { persistentTopicsRemoveMaxConsumersPerSubscriptionTenant :: Text -- ^ 
  , persistentTopicsRemoveMaxConsumersPerSubscriptionNamespace :: Text -- ^ 
  , persistentTopicsRemoveMaxConsumersPerSubscriptionTopic :: Text -- ^ 
  , persistentTopicsRemoveMaxConsumersPerSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveMaxConsumersPerSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveMaxConsumersPerSubscription :: PersistentTopicsRemoveMaxConsumersPerSubscriptionParameters -> ClientM NoContent
persistentTopicsRemoveMaxConsumersPerSubscription PersistentTopicsRemoveMaxConsumersPerSubscriptionParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveMaxConsumersPerSubscriptionAPI) (persistentTopicsRemoveMaxConsumersPerSubscriptionTenant) (persistentTopicsRemoveMaxConsumersPerSubscriptionNamespace) (persistentTopicsRemoveMaxConsumersPerSubscriptionTopic) (persistentTopicsRemoveMaxConsumersPerSubscriptionIsGlobal) (persistentTopicsRemoveMaxConsumersPerSubscriptionAuthoritative)

-- ^ 
type PersistentTopicsRemoveMaxMessageSizeAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxMessageSize" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveMaxMessageSizeParameters = PersistentTopicsRemoveMaxMessageSizeParameters
  { persistentTopicsRemoveMaxMessageSizeTenant :: Text -- ^ 
  , persistentTopicsRemoveMaxMessageSizeNamespace :: Text -- ^ 
  , persistentTopicsRemoveMaxMessageSizeTopic :: Text -- ^ 
  , persistentTopicsRemoveMaxMessageSizeIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveMaxMessageSizeAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveMaxMessageSize :: PersistentTopicsRemoveMaxMessageSizeParameters -> ClientM NoContent
persistentTopicsRemoveMaxMessageSize PersistentTopicsRemoveMaxMessageSizeParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveMaxMessageSizeAPI) (persistentTopicsRemoveMaxMessageSizeTenant) (persistentTopicsRemoveMaxMessageSizeNamespace) (persistentTopicsRemoveMaxMessageSizeTopic) (persistentTopicsRemoveMaxMessageSizeIsGlobal) (persistentTopicsRemoveMaxMessageSizeAuthoritative)

-- ^ 
type PersistentTopicsRemoveMaxProducersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxProducers" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveMaxProducersParameters = PersistentTopicsRemoveMaxProducersParameters
  { persistentTopicsRemoveMaxProducersTenant :: Text -- ^ 
  , persistentTopicsRemoveMaxProducersNamespace :: Text -- ^ 
  , persistentTopicsRemoveMaxProducersTopic :: Text -- ^ 
  , persistentTopicsRemoveMaxProducersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveMaxProducersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveMaxProducers :: PersistentTopicsRemoveMaxProducersParameters -> ClientM NoContent
persistentTopicsRemoveMaxProducers PersistentTopicsRemoveMaxProducersParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveMaxProducersAPI) (persistentTopicsRemoveMaxProducersTenant) (persistentTopicsRemoveMaxProducersNamespace) (persistentTopicsRemoveMaxProducersTopic) (persistentTopicsRemoveMaxProducersIsGlobal) (persistentTopicsRemoveMaxProducersAuthoritative)

-- ^ 
type PersistentTopicsRemoveMaxSubscriptionsPerTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxSubscriptionsPerTopic" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveMaxSubscriptionsPerTopicParameters = PersistentTopicsRemoveMaxSubscriptionsPerTopicParameters
  { persistentTopicsRemoveMaxSubscriptionsPerTopicTenant :: Text -- ^ 
  , persistentTopicsRemoveMaxSubscriptionsPerTopicNamespace :: Text -- ^ 
  , persistentTopicsRemoveMaxSubscriptionsPerTopicTopic :: Text -- ^ 
  , persistentTopicsRemoveMaxSubscriptionsPerTopicIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveMaxSubscriptionsPerTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveMaxSubscriptionsPerTopic :: PersistentTopicsRemoveMaxSubscriptionsPerTopicParameters -> ClientM NoContent
persistentTopicsRemoveMaxSubscriptionsPerTopic PersistentTopicsRemoveMaxSubscriptionsPerTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveMaxSubscriptionsPerTopicAPI) (persistentTopicsRemoveMaxSubscriptionsPerTopicTenant) (persistentTopicsRemoveMaxSubscriptionsPerTopicNamespace) (persistentTopicsRemoveMaxSubscriptionsPerTopicTopic) (persistentTopicsRemoveMaxSubscriptionsPerTopicIsGlobal) (persistentTopicsRemoveMaxSubscriptionsPerTopicAuthoritative)

-- ^ 
type PersistentTopicsRemoveMessageTTLAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "messageTTL" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveMessageTTLParameters = PersistentTopicsRemoveMessageTTLParameters
  { persistentTopicsRemoveMessageTTLTenant :: Text -- ^ 
  , persistentTopicsRemoveMessageTTLNamespace :: Text -- ^ 
  , persistentTopicsRemoveMessageTTLTopic :: Text -- ^ 
  , persistentTopicsRemoveMessageTTLIsGlobal :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsRemoveMessageTTLAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveMessageTTL :: PersistentTopicsRemoveMessageTTLParameters -> ClientM NoContent
persistentTopicsRemoveMessageTTL PersistentTopicsRemoveMessageTTLParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveMessageTTLAPI) (persistentTopicsRemoveMessageTTLTenant) (persistentTopicsRemoveMessageTTLNamespace) (persistentTopicsRemoveMessageTTLTopic) (persistentTopicsRemoveMessageTTLIsGlobal) (persistentTopicsRemoveMessageTTLAuthoritative)

-- ^ 
type PersistentTopicsRemoveOffloadPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offloadPolicies" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveOffloadPoliciesParameters = PersistentTopicsRemoveOffloadPoliciesParameters
  { persistentTopicsRemoveOffloadPoliciesTenant :: Text -- ^ 
  , persistentTopicsRemoveOffloadPoliciesNamespace :: Text -- ^ 
  , persistentTopicsRemoveOffloadPoliciesTopic :: Text -- ^ 
  , persistentTopicsRemoveOffloadPoliciesIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveOffloadPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveOffloadPolicies :: PersistentTopicsRemoveOffloadPoliciesParameters -> ClientM NoContent
persistentTopicsRemoveOffloadPolicies PersistentTopicsRemoveOffloadPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveOffloadPoliciesAPI) (persistentTopicsRemoveOffloadPoliciesTenant) (persistentTopicsRemoveOffloadPoliciesNamespace) (persistentTopicsRemoveOffloadPoliciesTopic) (persistentTopicsRemoveOffloadPoliciesIsGlobal) (persistentTopicsRemoveOffloadPoliciesAuthoritative)

-- ^ 
type PersistentTopicsRemovePersistenceAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "persistence" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemovePersistenceParameters = PersistentTopicsRemovePersistenceParameters
  { persistentTopicsRemovePersistenceTenant :: Text -- ^ 
  , persistentTopicsRemovePersistenceNamespace :: Text -- ^ 
  , persistentTopicsRemovePersistenceTopic :: Text -- ^ 
  , persistentTopicsRemovePersistenceIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemovePersistenceAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemovePersistence :: PersistentTopicsRemovePersistenceParameters -> ClientM NoContent
persistentTopicsRemovePersistence PersistentTopicsRemovePersistenceParameters {..} = client (Proxy :: Proxy PersistentTopicsRemovePersistenceAPI) (persistentTopicsRemovePersistenceTenant) (persistentTopicsRemovePersistenceNamespace) (persistentTopicsRemovePersistenceTopic) (persistentTopicsRemovePersistenceIsGlobal) (persistentTopicsRemovePersistenceAuthoritative)

-- ^ 
type PersistentTopicsRemovePropertiesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "properties" :> QueryParam "key" Text :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemovePropertiesParameters = PersistentTopicsRemovePropertiesParameters
  { persistentTopicsRemovePropertiesTenant :: Text -- ^ Specify the tenant
  , persistentTopicsRemovePropertiesNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsRemovePropertiesTopic :: Text -- ^ Specify topic name
  , persistentTopicsRemovePropertiesKey :: Maybe Text -- ^ 
  , persistentTopicsRemovePropertiesAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveProperties :: PersistentTopicsRemovePropertiesParameters -> ClientM NoContent
persistentTopicsRemoveProperties PersistentTopicsRemovePropertiesParameters {..} = client (Proxy :: Proxy PersistentTopicsRemovePropertiesAPI) (persistentTopicsRemovePropertiesTenant) (persistentTopicsRemovePropertiesNamespace) (persistentTopicsRemovePropertiesTopic) (persistentTopicsRemovePropertiesKey) (persistentTopicsRemovePropertiesAuthoritative)

-- ^ 
type PersistentTopicsRemovePublishRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "publishRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemovePublishRateParameters = PersistentTopicsRemovePublishRateParameters
  { persistentTopicsRemovePublishRateTenant :: Text -- ^ 
  , persistentTopicsRemovePublishRateNamespace :: Text -- ^ 
  , persistentTopicsRemovePublishRateTopic :: Text -- ^ 
  , persistentTopicsRemovePublishRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemovePublishRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemovePublishRate :: PersistentTopicsRemovePublishRateParameters -> ClientM NoContent
persistentTopicsRemovePublishRate PersistentTopicsRemovePublishRateParameters {..} = client (Proxy :: Proxy PersistentTopicsRemovePublishRateAPI) (persistentTopicsRemovePublishRateTenant) (persistentTopicsRemovePublishRateNamespace) (persistentTopicsRemovePublishRateTopic) (persistentTopicsRemovePublishRateIsGlobal) (persistentTopicsRemovePublishRateAuthoritative)

-- ^ 
type PersistentTopicsRemoveReplicationClustersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replication" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveReplicationClustersParameters = PersistentTopicsRemoveReplicationClustersParameters
  { persistentTopicsRemoveReplicationClustersTenant :: Text -- ^ 
  , persistentTopicsRemoveReplicationClustersNamespace :: Text -- ^ 
  , persistentTopicsRemoveReplicationClustersTopic :: Text -- ^ 
  , persistentTopicsRemoveReplicationClustersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveReplicationClustersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveReplicationClusters :: PersistentTopicsRemoveReplicationClustersParameters -> ClientM NoContent
persistentTopicsRemoveReplicationClusters PersistentTopicsRemoveReplicationClustersParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveReplicationClustersAPI) (persistentTopicsRemoveReplicationClustersTenant) (persistentTopicsRemoveReplicationClustersNamespace) (persistentTopicsRemoveReplicationClustersTopic) (persistentTopicsRemoveReplicationClustersIsGlobal) (persistentTopicsRemoveReplicationClustersAuthoritative)

-- ^ 
type PersistentTopicsRemoveReplicatorDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replicatorDispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveReplicatorDispatchRateParameters = PersistentTopicsRemoveReplicatorDispatchRateParameters
  { persistentTopicsRemoveReplicatorDispatchRateTenant :: Text -- ^ 
  , persistentTopicsRemoveReplicatorDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsRemoveReplicatorDispatchRateTopic :: Text -- ^ 
  , persistentTopicsRemoveReplicatorDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveReplicatorDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveReplicatorDispatchRate :: PersistentTopicsRemoveReplicatorDispatchRateParameters -> ClientM NoContent
persistentTopicsRemoveReplicatorDispatchRate PersistentTopicsRemoveReplicatorDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveReplicatorDispatchRateAPI) (persistentTopicsRemoveReplicatorDispatchRateTenant) (persistentTopicsRemoveReplicatorDispatchRateNamespace) (persistentTopicsRemoveReplicatorDispatchRateTopic) (persistentTopicsRemoveReplicatorDispatchRateIsGlobal) (persistentTopicsRemoveReplicatorDispatchRateAuthoritative)

-- ^ 
type PersistentTopicsRemoveRetentionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "retention" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveRetentionParameters = PersistentTopicsRemoveRetentionParameters
  { persistentTopicsRemoveRetentionTenant :: Text -- ^ 
  , persistentTopicsRemoveRetentionNamespace :: Text -- ^ 
  , persistentTopicsRemoveRetentionTopic :: Text -- ^ 
  , persistentTopicsRemoveRetentionIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveRetentionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveRetention :: PersistentTopicsRemoveRetentionParameters -> ClientM NoContent
persistentTopicsRemoveRetention PersistentTopicsRemoveRetentionParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveRetentionAPI) (persistentTopicsRemoveRetentionTenant) (persistentTopicsRemoveRetentionNamespace) (persistentTopicsRemoveRetentionTopic) (persistentTopicsRemoveRetentionIsGlobal) (persistentTopicsRemoveRetentionAuthoritative)

-- ^ 
type PersistentTopicsRemoveSchemaCompatibilityStrategyAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaCompatibilityStrategy" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Text :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveSchemaCompatibilityStrategyParameters = PersistentTopicsRemoveSchemaCompatibilityStrategyParameters
  { persistentTopicsRemoveSchemaCompatibilityStrategyTenant :: Text -- ^ Specify the tenant
  , persistentTopicsRemoveSchemaCompatibilityStrategyNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsRemoveSchemaCompatibilityStrategyTopic :: Text -- ^ Specify topic name
  , persistentTopicsRemoveSchemaCompatibilityStrategyAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsRemoveSchemaCompatibilityStrategyBody :: Text -- ^ Strategy used to check the compatibility of new schema
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveSchemaCompatibilityStrategy :: PersistentTopicsRemoveSchemaCompatibilityStrategyParameters -> ClientM NoContent
persistentTopicsRemoveSchemaCompatibilityStrategy PersistentTopicsRemoveSchemaCompatibilityStrategyParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveSchemaCompatibilityStrategyAPI) (persistentTopicsRemoveSchemaCompatibilityStrategyTenant) (persistentTopicsRemoveSchemaCompatibilityStrategyNamespace) (persistentTopicsRemoveSchemaCompatibilityStrategyTopic) (persistentTopicsRemoveSchemaCompatibilityStrategyAuthoritative) persistentTopicsRemoveSchemaCompatibilityStrategyBody

-- ^ 
type PersistentTopicsRemoveSubscribeRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscribeRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] SubscribeRate :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveSubscribeRateParameters = PersistentTopicsRemoveSubscribeRateParameters
  { persistentTopicsRemoveSubscribeRateTenant :: Text -- ^ 
  , persistentTopicsRemoveSubscribeRateNamespace :: Text -- ^ 
  , persistentTopicsRemoveSubscribeRateTopic :: Text -- ^ 
  , persistentTopicsRemoveSubscribeRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveSubscribeRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsRemoveSubscribeRateBody :: SubscribeRate -- ^ Subscribe rate for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveSubscribeRate :: PersistentTopicsRemoveSubscribeRateParameters -> ClientM NoContent
persistentTopicsRemoveSubscribeRate PersistentTopicsRemoveSubscribeRateParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveSubscribeRateAPI) (persistentTopicsRemoveSubscribeRateTenant) (persistentTopicsRemoveSubscribeRateNamespace) (persistentTopicsRemoveSubscribeRateTopic) (persistentTopicsRemoveSubscribeRateIsGlobal) (persistentTopicsRemoveSubscribeRateAuthoritative) persistentTopicsRemoveSubscribeRateBody

-- ^ 
type PersistentTopicsRemoveSubscriptionDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionDispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveSubscriptionDispatchRateParameters = PersistentTopicsRemoveSubscriptionDispatchRateParameters
  { persistentTopicsRemoveSubscriptionDispatchRateTenant :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionDispatchRateTopic :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveSubscriptionDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveSubscriptionDispatchRate :: PersistentTopicsRemoveSubscriptionDispatchRateParameters -> ClientM NoContent
persistentTopicsRemoveSubscriptionDispatchRate PersistentTopicsRemoveSubscriptionDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveSubscriptionDispatchRateAPI) (persistentTopicsRemoveSubscriptionDispatchRateTenant) (persistentTopicsRemoveSubscriptionDispatchRateNamespace) (persistentTopicsRemoveSubscriptionDispatchRateTopic) (persistentTopicsRemoveSubscriptionDispatchRateIsGlobal) (persistentTopicsRemoveSubscriptionDispatchRateAuthoritative)

-- ^ 
type PersistentTopicsRemoveSubscriptionLevelDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> Capture "subName" Text :> "dispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveSubscriptionLevelDispatchRateParameters = PersistentTopicsRemoveSubscriptionLevelDispatchRateParameters
  { persistentTopicsRemoveSubscriptionLevelDispatchRateTenant :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionLevelDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionLevelDispatchRateTopic :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionLevelDispatchRateSubName :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionLevelDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveSubscriptionLevelDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveSubscriptionLevelDispatchRate :: PersistentTopicsRemoveSubscriptionLevelDispatchRateParameters -> ClientM NoContent
persistentTopicsRemoveSubscriptionLevelDispatchRate PersistentTopicsRemoveSubscriptionLevelDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveSubscriptionLevelDispatchRateAPI) (persistentTopicsRemoveSubscriptionLevelDispatchRateTenant) (persistentTopicsRemoveSubscriptionLevelDispatchRateNamespace) (persistentTopicsRemoveSubscriptionLevelDispatchRateTopic) (persistentTopicsRemoveSubscriptionLevelDispatchRateSubName) (persistentTopicsRemoveSubscriptionLevelDispatchRateIsGlobal) (persistentTopicsRemoveSubscriptionLevelDispatchRateAuthoritative)

-- ^ 
type PersistentTopicsRemoveSubscriptionTypesEnabledAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionTypesEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRemoveSubscriptionTypesEnabledParameters = PersistentTopicsRemoveSubscriptionTypesEnabledParameters
  { persistentTopicsRemoveSubscriptionTypesEnabledTenant :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionTypesEnabledNamespace :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionTypesEnabledTopic :: Text -- ^ 
  , persistentTopicsRemoveSubscriptionTypesEnabledIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsRemoveSubscriptionTypesEnabledAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsRemoveSubscriptionTypesEnabled :: PersistentTopicsRemoveSubscriptionTypesEnabledParameters -> ClientM NoContent
persistentTopicsRemoveSubscriptionTypesEnabled PersistentTopicsRemoveSubscriptionTypesEnabledParameters {..} = client (Proxy :: Proxy PersistentTopicsRemoveSubscriptionTypesEnabledAPI) (persistentTopicsRemoveSubscriptionTypesEnabledTenant) (persistentTopicsRemoveSubscriptionTypesEnabledNamespace) (persistentTopicsRemoveSubscriptionTypesEnabledTopic) (persistentTopicsRemoveSubscriptionTypesEnabledIsGlobal) (persistentTopicsRemoveSubscriptionTypesEnabledAuthoritative)

-- ^ It fence cursor and disconnects all active consumers before resetting cursor.
type PersistentTopicsResetCursorAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "resetcursor" :> Capture "timestamp" Integer :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsResetCursorParameters = PersistentTopicsResetCursorParameters
  { persistentTopicsResetCursorTenant :: Text -- ^ Specify the tenant
  , persistentTopicsResetCursorNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsResetCursorTopic :: Text -- ^ Specify topic name
  , persistentTopicsResetCursorSubName :: Text -- ^ Subscription to reset position on
  , persistentTopicsResetCursorTimestamp :: Integer -- ^ the timestamp to reset back
  , persistentTopicsResetCursorAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsResetCursor :: PersistentTopicsResetCursorParameters -> ClientM NoContent
persistentTopicsResetCursor PersistentTopicsResetCursorParameters {..} = client (Proxy :: Proxy PersistentTopicsResetCursorAPI) (persistentTopicsResetCursorTenant) (persistentTopicsResetCursorNamespace) (persistentTopicsResetCursorTopic) (persistentTopicsResetCursorSubName) (persistentTopicsResetCursorTimestamp) (persistentTopicsResetCursorAuthoritative)

-- ^ It fence cursor and disconnects all active consumers before resetting cursor.
type PersistentTopicsResetCursorOnPositionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "resetcursor" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] ResetCursorData :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsResetCursorOnPositionParameters = PersistentTopicsResetCursorOnPositionParameters
  { persistentTopicsResetCursorOnPositionTenant :: Text -- ^ Specify the tenant
  , persistentTopicsResetCursorOnPositionNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsResetCursorOnPositionTopic :: Text -- ^ Specify topic name
  , persistentTopicsResetCursorOnPositionSubName :: Text -- ^ Subscription to reset position on
  , persistentTopicsResetCursorOnPositionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsResetCursorOnPositionMessageId :: ResetCursorData -- ^ messageId to reset back to (ledgerId:entryId)
  } deriving (Show, Eq, Generic)

persistentTopicsResetCursorOnPosition :: PersistentTopicsResetCursorOnPositionParameters -> ClientM NoContent
persistentTopicsResetCursorOnPosition PersistentTopicsResetCursorOnPositionParameters {..} = client (Proxy :: Proxy PersistentTopicsResetCursorOnPositionAPI) (persistentTopicsResetCursorOnPositionTenant) (persistentTopicsResetCursorOnPositionNamespace) (persistentTopicsResetCursorOnPositionTopic) (persistentTopicsResetCursorOnPositionSubName) (persistentTopicsResetCursorOnPositionAuthoritative) persistentTopicsResetCursorOnPositionMessageId

-- ^ Revoke permissions to a role on a single topic. If the permission was not set at the topiclevel, but rather at the namespace level, this operation will return an error (HTTP status code 412).
type PersistentTopicsRevokePermissionsOnTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "permissions" :> Capture "role" Text :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsRevokePermissionsOnTopicParameters = PersistentTopicsRevokePermissionsOnTopicParameters
  { persistentTopicsRevokePermissionsOnTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsRevokePermissionsOnTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsRevokePermissionsOnTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsRevokePermissionsOnTopicRole :: Text -- ^ Client role to which grant permissions
  } deriving (Show, Eq, Generic)

persistentTopicsRevokePermissionsOnTopic :: PersistentTopicsRevokePermissionsOnTopicParameters -> ClientM NoContent
persistentTopicsRevokePermissionsOnTopic PersistentTopicsRevokePermissionsOnTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsRevokePermissionsOnTopicAPI) (persistentTopicsRevokePermissionsOnTopicTenant) (persistentTopicsRevokePermissionsOnTopicNamespace) (persistentTopicsRevokePermissionsOnTopicTopic) (persistentTopicsRevokePermissionsOnTopicRole)

-- ^ 
type PersistentTopicsSetAutoSubscriptionCreationAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "autoSubscriptionCreation" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] AutoSubscriptionCreationOverrideImpl :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetAutoSubscriptionCreationParameters = PersistentTopicsSetAutoSubscriptionCreationParameters
  { persistentTopicsSetAutoSubscriptionCreationTenant :: Text -- ^ 
  , persistentTopicsSetAutoSubscriptionCreationNamespace :: Text -- ^ 
  , persistentTopicsSetAutoSubscriptionCreationTopic :: Text -- ^ 
  , persistentTopicsSetAutoSubscriptionCreationIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetAutoSubscriptionCreationAuthoritative :: Maybe Bool -- ^ 
  , persistentTopicsSetAutoSubscriptionCreationBody :: AutoSubscriptionCreationOverrideImpl -- ^ Settings for automatic subscription creation
  } deriving (Show, Eq, Generic)

persistentTopicsSetAutoSubscriptionCreation :: PersistentTopicsSetAutoSubscriptionCreationParameters -> ClientM NoContent
persistentTopicsSetAutoSubscriptionCreation PersistentTopicsSetAutoSubscriptionCreationParameters {..} = client (Proxy :: Proxy PersistentTopicsSetAutoSubscriptionCreationAPI) (persistentTopicsSetAutoSubscriptionCreationTenant) (persistentTopicsSetAutoSubscriptionCreationNamespace) (persistentTopicsSetAutoSubscriptionCreationTopic) (persistentTopicsSetAutoSubscriptionCreationIsGlobal) (persistentTopicsSetAutoSubscriptionCreationAuthoritative) persistentTopicsSetAutoSubscriptionCreationBody

-- ^ 
type PersistentTopicsSetBacklogQuotaAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "backlogQuota" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> QueryParam "backlogQuotaType" Text :> ReqBody '[JSON] BacklogQuotaImpl :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetBacklogQuotaParameters = PersistentTopicsSetBacklogQuotaParameters
  { persistentTopicsSetBacklogQuotaTenant :: Text -- ^ 
  , persistentTopicsSetBacklogQuotaNamespace :: Text -- ^ 
  , persistentTopicsSetBacklogQuotaTopic :: Text -- ^ 
  , persistentTopicsSetBacklogQuotaAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetBacklogQuotaIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetBacklogQuotaBacklogQuotaType :: Maybe Text -- ^ 
  , persistentTopicsSetBacklogQuotaBody :: BacklogQuotaImpl -- ^ backlog quota policies for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetBacklogQuota :: PersistentTopicsSetBacklogQuotaParameters -> ClientM NoContent
persistentTopicsSetBacklogQuota PersistentTopicsSetBacklogQuotaParameters {..} = client (Proxy :: Proxy PersistentTopicsSetBacklogQuotaAPI) (persistentTopicsSetBacklogQuotaTenant) (persistentTopicsSetBacklogQuotaNamespace) (persistentTopicsSetBacklogQuotaTopic) (persistentTopicsSetBacklogQuotaAuthoritative) (persistentTopicsSetBacklogQuotaIsGlobal) (persistentTopicsSetBacklogQuotaBacklogQuotaType) persistentTopicsSetBacklogQuotaBody

-- ^ 
type PersistentTopicsSetCompactionThresholdAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compactionThreshold" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] Integer :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetCompactionThresholdParameters = PersistentTopicsSetCompactionThresholdParameters
  { persistentTopicsSetCompactionThresholdTenant :: Text -- ^ 
  , persistentTopicsSetCompactionThresholdNamespace :: Text -- ^ 
  , persistentTopicsSetCompactionThresholdTopic :: Text -- ^ 
  , persistentTopicsSetCompactionThresholdAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetCompactionThresholdIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetCompactionThresholdBody :: Integer -- ^ Dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetCompactionThreshold :: PersistentTopicsSetCompactionThresholdParameters -> ClientM NoContent
persistentTopicsSetCompactionThreshold PersistentTopicsSetCompactionThresholdParameters {..} = client (Proxy :: Proxy PersistentTopicsSetCompactionThresholdAPI) (persistentTopicsSetCompactionThresholdTenant) (persistentTopicsSetCompactionThresholdNamespace) (persistentTopicsSetCompactionThresholdTopic) (persistentTopicsSetCompactionThresholdAuthoritative) (persistentTopicsSetCompactionThresholdIsGlobal) persistentTopicsSetCompactionThresholdBody

-- ^ 
type PersistentTopicsSetDeduplicationAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetDeduplicationParameters = PersistentTopicsSetDeduplicationParameters
  { persistentTopicsSetDeduplicationTenant :: Text -- ^ 
  , persistentTopicsSetDeduplicationNamespace :: Text -- ^ 
  , persistentTopicsSetDeduplicationTopic :: Text -- ^ 
  , persistentTopicsSetDeduplicationIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetDeduplicationAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetDeduplicationBody :: Bool -- ^ DeduplicationEnabled policies for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetDeduplication :: PersistentTopicsSetDeduplicationParameters -> ClientM NoContent
persistentTopicsSetDeduplication PersistentTopicsSetDeduplicationParameters {..} = client (Proxy :: Proxy PersistentTopicsSetDeduplicationAPI) (persistentTopicsSetDeduplicationTenant) (persistentTopicsSetDeduplicationNamespace) (persistentTopicsSetDeduplicationTopic) (persistentTopicsSetDeduplicationIsGlobal) (persistentTopicsSetDeduplicationAuthoritative) persistentTopicsSetDeduplicationBody

-- ^ 
type PersistentTopicsSetDeduplicationSnapshotIntervalAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "deduplicationSnapshotInterval" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetDeduplicationSnapshotIntervalParameters = PersistentTopicsSetDeduplicationSnapshotIntervalParameters
  { persistentTopicsSetDeduplicationSnapshotIntervalTenant :: Text -- ^ 
  , persistentTopicsSetDeduplicationSnapshotIntervalNamespace :: Text -- ^ 
  , persistentTopicsSetDeduplicationSnapshotIntervalTopic :: Text -- ^ 
  , persistentTopicsSetDeduplicationSnapshotIntervalIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetDeduplicationSnapshotIntervalAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetDeduplicationSnapshotIntervalBody :: Int -- ^ Interval to take deduplication snapshot for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetDeduplicationSnapshotInterval :: PersistentTopicsSetDeduplicationSnapshotIntervalParameters -> ClientM NoContent
persistentTopicsSetDeduplicationSnapshotInterval PersistentTopicsSetDeduplicationSnapshotIntervalParameters {..} = client (Proxy :: Proxy PersistentTopicsSetDeduplicationSnapshotIntervalAPI) (persistentTopicsSetDeduplicationSnapshotIntervalTenant) (persistentTopicsSetDeduplicationSnapshotIntervalNamespace) (persistentTopicsSetDeduplicationSnapshotIntervalTopic) (persistentTopicsSetDeduplicationSnapshotIntervalIsGlobal) (persistentTopicsSetDeduplicationSnapshotIntervalAuthoritative) persistentTopicsSetDeduplicationSnapshotIntervalBody

-- ^ 
type PersistentTopicsSetDelayedDeliveryPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "delayedDelivery" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] DelayedDeliveryPolicies :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetDelayedDeliveryPoliciesParameters = PersistentTopicsSetDelayedDeliveryPoliciesParameters
  { persistentTopicsSetDelayedDeliveryPoliciesTenant :: Text -- ^ 
  , persistentTopicsSetDelayedDeliveryPoliciesNamespace :: Text -- ^ 
  , persistentTopicsSetDelayedDeliveryPoliciesTopic :: Text -- ^ 
  , persistentTopicsSetDelayedDeliveryPoliciesIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetDelayedDeliveryPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetDelayedDeliveryPoliciesBody :: DelayedDeliveryPolicies -- ^ Delayed delivery policies for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetDelayedDeliveryPolicies :: PersistentTopicsSetDelayedDeliveryPoliciesParameters -> ClientM NoContent
persistentTopicsSetDelayedDeliveryPolicies PersistentTopicsSetDelayedDeliveryPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsSetDelayedDeliveryPoliciesAPI) (persistentTopicsSetDelayedDeliveryPoliciesTenant) (persistentTopicsSetDelayedDeliveryPoliciesNamespace) (persistentTopicsSetDelayedDeliveryPoliciesTopic) (persistentTopicsSetDelayedDeliveryPoliciesIsGlobal) (persistentTopicsSetDelayedDeliveryPoliciesAuthoritative) persistentTopicsSetDelayedDeliveryPoliciesBody

-- ^ 
type PersistentTopicsSetDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatchRate" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetDispatchRateParameters = PersistentTopicsSetDispatchRateParameters
  { persistentTopicsSetDispatchRateTenant :: Text -- ^ 
  , persistentTopicsSetDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsSetDispatchRateTopic :: Text -- ^ 
  , persistentTopicsSetDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetDispatchRateBody :: DispatchRateImpl -- ^ Dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetDispatchRate :: PersistentTopicsSetDispatchRateParameters -> ClientM NoContent
persistentTopicsSetDispatchRate PersistentTopicsSetDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsSetDispatchRateAPI) (persistentTopicsSetDispatchRateTenant) (persistentTopicsSetDispatchRateNamespace) (persistentTopicsSetDispatchRateTopic) (persistentTopicsSetDispatchRateAuthoritative) (persistentTopicsSetDispatchRateIsGlobal) persistentTopicsSetDispatchRateBody

-- ^ 
type PersistentTopicsSetDispatcherPauseOnAckStatePersistentAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "dispatcherPauseOnAckStatePersistent" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters = PersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters
  { persistentTopicsSetDispatcherPauseOnAckStatePersistentTenant :: Text -- ^ 
  , persistentTopicsSetDispatcherPauseOnAckStatePersistentNamespace :: Text -- ^ 
  , persistentTopicsSetDispatcherPauseOnAckStatePersistentTopic :: Text -- ^ 
  , persistentTopicsSetDispatcherPauseOnAckStatePersistentAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetDispatcherPauseOnAckStatePersistentIsGlobal :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsSetDispatcherPauseOnAckStatePersistent :: PersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters -> ClientM NoContent
persistentTopicsSetDispatcherPauseOnAckStatePersistent PersistentTopicsSetDispatcherPauseOnAckStatePersistentParameters {..} = client (Proxy :: Proxy PersistentTopicsSetDispatcherPauseOnAckStatePersistentAPI) (persistentTopicsSetDispatcherPauseOnAckStatePersistentTenant) (persistentTopicsSetDispatcherPauseOnAckStatePersistentNamespace) (persistentTopicsSetDispatcherPauseOnAckStatePersistentTopic) (persistentTopicsSetDispatcherPauseOnAckStatePersistentAuthoritative) (persistentTopicsSetDispatcherPauseOnAckStatePersistentIsGlobal)

-- ^ 
type PersistentTopicsSetEntryFiltersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "entryFilters" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] EntryFilters :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetEntryFiltersParameters = PersistentTopicsSetEntryFiltersParameters
  { persistentTopicsSetEntryFiltersTenant :: Text -- ^ 
  , persistentTopicsSetEntryFiltersNamespace :: Text -- ^ 
  , persistentTopicsSetEntryFiltersTopic :: Text -- ^ 
  , persistentTopicsSetEntryFiltersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetEntryFiltersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected thiscall to this broker. For internal use.
  , persistentTopicsSetEntryFiltersBody :: EntryFilters -- ^ Entry filters for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetEntryFilters :: PersistentTopicsSetEntryFiltersParameters -> ClientM NoContent
persistentTopicsSetEntryFilters PersistentTopicsSetEntryFiltersParameters {..} = client (Proxy :: Proxy PersistentTopicsSetEntryFiltersAPI) (persistentTopicsSetEntryFiltersTenant) (persistentTopicsSetEntryFiltersNamespace) (persistentTopicsSetEntryFiltersTopic) (persistentTopicsSetEntryFiltersIsGlobal) (persistentTopicsSetEntryFiltersAuthoritative) persistentTopicsSetEntryFiltersBody

-- ^ 
type PersistentTopicsSetInactiveTopicPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "inactiveTopicPolicies" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] InactiveTopicPolicies :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetInactiveTopicPoliciesParameters = PersistentTopicsSetInactiveTopicPoliciesParameters
  { persistentTopicsSetInactiveTopicPoliciesTenant :: Text -- ^ 
  , persistentTopicsSetInactiveTopicPoliciesNamespace :: Text -- ^ 
  , persistentTopicsSetInactiveTopicPoliciesTopic :: Text -- ^ 
  , persistentTopicsSetInactiveTopicPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetInactiveTopicPoliciesIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetInactiveTopicPoliciesBody :: InactiveTopicPolicies -- ^ inactive topic policies for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetInactiveTopicPolicies :: PersistentTopicsSetInactiveTopicPoliciesParameters -> ClientM NoContent
persistentTopicsSetInactiveTopicPolicies PersistentTopicsSetInactiveTopicPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsSetInactiveTopicPoliciesAPI) (persistentTopicsSetInactiveTopicPoliciesTenant) (persistentTopicsSetInactiveTopicPoliciesNamespace) (persistentTopicsSetInactiveTopicPoliciesTopic) (persistentTopicsSetInactiveTopicPoliciesAuthoritative) (persistentTopicsSetInactiveTopicPoliciesIsGlobal) persistentTopicsSetInactiveTopicPoliciesBody

-- ^ 
type PersistentTopicsSetMaxConsumersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumers" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetMaxConsumersParameters = PersistentTopicsSetMaxConsumersParameters
  { persistentTopicsSetMaxConsumersTenant :: Text -- ^ 
  , persistentTopicsSetMaxConsumersNamespace :: Text -- ^ 
  , persistentTopicsSetMaxConsumersTopic :: Text -- ^ 
  , persistentTopicsSetMaxConsumersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetMaxConsumersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetMaxConsumersBody :: Int -- ^ The max consumers of the topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetMaxConsumers :: PersistentTopicsSetMaxConsumersParameters -> ClientM NoContent
persistentTopicsSetMaxConsumers PersistentTopicsSetMaxConsumersParameters {..} = client (Proxy :: Proxy PersistentTopicsSetMaxConsumersAPI) (persistentTopicsSetMaxConsumersTenant) (persistentTopicsSetMaxConsumersNamespace) (persistentTopicsSetMaxConsumersTopic) (persistentTopicsSetMaxConsumersIsGlobal) (persistentTopicsSetMaxConsumersAuthoritative) persistentTopicsSetMaxConsumersBody

-- ^ 
type PersistentTopicsSetMaxConsumersPerSubscriptionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxConsumersPerSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetMaxConsumersPerSubscriptionParameters = PersistentTopicsSetMaxConsumersPerSubscriptionParameters
  { persistentTopicsSetMaxConsumersPerSubscriptionTenant :: Text -- ^ 
  , persistentTopicsSetMaxConsumersPerSubscriptionNamespace :: Text -- ^ 
  , persistentTopicsSetMaxConsumersPerSubscriptionTopic :: Text -- ^ 
  , persistentTopicsSetMaxConsumersPerSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetMaxConsumersPerSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetMaxConsumersPerSubscriptionBody :: Int -- ^ Dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetMaxConsumersPerSubscription :: PersistentTopicsSetMaxConsumersPerSubscriptionParameters -> ClientM NoContent
persistentTopicsSetMaxConsumersPerSubscription PersistentTopicsSetMaxConsumersPerSubscriptionParameters {..} = client (Proxy :: Proxy PersistentTopicsSetMaxConsumersPerSubscriptionAPI) (persistentTopicsSetMaxConsumersPerSubscriptionTenant) (persistentTopicsSetMaxConsumersPerSubscriptionNamespace) (persistentTopicsSetMaxConsumersPerSubscriptionTopic) (persistentTopicsSetMaxConsumersPerSubscriptionIsGlobal) (persistentTopicsSetMaxConsumersPerSubscriptionAuthoritative) persistentTopicsSetMaxConsumersPerSubscriptionBody

-- ^ 
type PersistentTopicsSetMaxMessageSizeAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxMessageSize" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetMaxMessageSizeParameters = PersistentTopicsSetMaxMessageSizeParameters
  { persistentTopicsSetMaxMessageSizeTenant :: Text -- ^ 
  , persistentTopicsSetMaxMessageSizeNamespace :: Text -- ^ 
  , persistentTopicsSetMaxMessageSizeTopic :: Text -- ^ 
  , persistentTopicsSetMaxMessageSizeIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetMaxMessageSizeAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetMaxMessageSizeBody :: Int -- ^ The max message size of the topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetMaxMessageSize :: PersistentTopicsSetMaxMessageSizeParameters -> ClientM NoContent
persistentTopicsSetMaxMessageSize PersistentTopicsSetMaxMessageSizeParameters {..} = client (Proxy :: Proxy PersistentTopicsSetMaxMessageSizeAPI) (persistentTopicsSetMaxMessageSizeTenant) (persistentTopicsSetMaxMessageSizeNamespace) (persistentTopicsSetMaxMessageSizeTopic) (persistentTopicsSetMaxMessageSizeIsGlobal) (persistentTopicsSetMaxMessageSizeAuthoritative) persistentTopicsSetMaxMessageSizeBody

-- ^ 
type PersistentTopicsSetMaxProducersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxProducers" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetMaxProducersParameters = PersistentTopicsSetMaxProducersParameters
  { persistentTopicsSetMaxProducersTenant :: Text -- ^ 
  , persistentTopicsSetMaxProducersNamespace :: Text -- ^ 
  , persistentTopicsSetMaxProducersTopic :: Text -- ^ 
  , persistentTopicsSetMaxProducersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetMaxProducersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetMaxProducersBody :: Int -- ^ The max producers of the topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetMaxProducers :: PersistentTopicsSetMaxProducersParameters -> ClientM NoContent
persistentTopicsSetMaxProducers PersistentTopicsSetMaxProducersParameters {..} = client (Proxy :: Proxy PersistentTopicsSetMaxProducersAPI) (persistentTopicsSetMaxProducersTenant) (persistentTopicsSetMaxProducersNamespace) (persistentTopicsSetMaxProducersTopic) (persistentTopicsSetMaxProducersAuthoritative) (persistentTopicsSetMaxProducersIsGlobal) persistentTopicsSetMaxProducersBody

-- ^ 
type PersistentTopicsSetMaxSubscriptionsPerTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxSubscriptionsPerTopic" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetMaxSubscriptionsPerTopicParameters = PersistentTopicsSetMaxSubscriptionsPerTopicParameters
  { persistentTopicsSetMaxSubscriptionsPerTopicTenant :: Text -- ^ 
  , persistentTopicsSetMaxSubscriptionsPerTopicNamespace :: Text -- ^ 
  , persistentTopicsSetMaxSubscriptionsPerTopicTopic :: Text -- ^ 
  , persistentTopicsSetMaxSubscriptionsPerTopicIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetMaxSubscriptionsPerTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetMaxSubscriptionsPerTopicBody :: Int -- ^ The max subscriptions of the topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetMaxSubscriptionsPerTopic :: PersistentTopicsSetMaxSubscriptionsPerTopicParameters -> ClientM NoContent
persistentTopicsSetMaxSubscriptionsPerTopic PersistentTopicsSetMaxSubscriptionsPerTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsSetMaxSubscriptionsPerTopicAPI) (persistentTopicsSetMaxSubscriptionsPerTopicTenant) (persistentTopicsSetMaxSubscriptionsPerTopicNamespace) (persistentTopicsSetMaxSubscriptionsPerTopicTopic) (persistentTopicsSetMaxSubscriptionsPerTopicIsGlobal) (persistentTopicsSetMaxSubscriptionsPerTopicAuthoritative) persistentTopicsSetMaxSubscriptionsPerTopicBody

-- ^ 
type PersistentTopicsSetMaxUnackedMessagesOnConsumerAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnConsumer" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetMaxUnackedMessagesOnConsumerParameters = PersistentTopicsSetMaxUnackedMessagesOnConsumerParameters
  { persistentTopicsSetMaxUnackedMessagesOnConsumerTenant :: Text -- ^ 
  , persistentTopicsSetMaxUnackedMessagesOnConsumerNamespace :: Text -- ^ 
  , persistentTopicsSetMaxUnackedMessagesOnConsumerTopic :: Text -- ^ 
  , persistentTopicsSetMaxUnackedMessagesOnConsumerIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetMaxUnackedMessagesOnConsumerAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetMaxUnackedMessagesOnConsumerBody :: Int -- ^ Max unacked messages on consumer policies for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetMaxUnackedMessagesOnConsumer :: PersistentTopicsSetMaxUnackedMessagesOnConsumerParameters -> ClientM NoContent
persistentTopicsSetMaxUnackedMessagesOnConsumer PersistentTopicsSetMaxUnackedMessagesOnConsumerParameters {..} = client (Proxy :: Proxy PersistentTopicsSetMaxUnackedMessagesOnConsumerAPI) (persistentTopicsSetMaxUnackedMessagesOnConsumerTenant) (persistentTopicsSetMaxUnackedMessagesOnConsumerNamespace) (persistentTopicsSetMaxUnackedMessagesOnConsumerTopic) (persistentTopicsSetMaxUnackedMessagesOnConsumerIsGlobal) (persistentTopicsSetMaxUnackedMessagesOnConsumerAuthoritative) persistentTopicsSetMaxUnackedMessagesOnConsumerBody

-- ^ 
type PersistentTopicsSetMaxUnackedMessagesOnSubscriptionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "maxUnackedMessagesOnSubscription" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters = PersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters
  { persistentTopicsSetMaxUnackedMessagesOnSubscriptionTenant :: Text -- ^ 
  , persistentTopicsSetMaxUnackedMessagesOnSubscriptionNamespace :: Text -- ^ 
  , persistentTopicsSetMaxUnackedMessagesOnSubscriptionTopic :: Text -- ^ 
  , persistentTopicsSetMaxUnackedMessagesOnSubscriptionIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetMaxUnackedMessagesOnSubscriptionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetMaxUnackedMessagesOnSubscriptionBody :: Int -- ^ Max unacked messages on subscription policies for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetMaxUnackedMessagesOnSubscription :: PersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters -> ClientM NoContent
persistentTopicsSetMaxUnackedMessagesOnSubscription PersistentTopicsSetMaxUnackedMessagesOnSubscriptionParameters {..} = client (Proxy :: Proxy PersistentTopicsSetMaxUnackedMessagesOnSubscriptionAPI) (persistentTopicsSetMaxUnackedMessagesOnSubscriptionTenant) (persistentTopicsSetMaxUnackedMessagesOnSubscriptionNamespace) (persistentTopicsSetMaxUnackedMessagesOnSubscriptionTopic) (persistentTopicsSetMaxUnackedMessagesOnSubscriptionIsGlobal) (persistentTopicsSetMaxUnackedMessagesOnSubscriptionAuthoritative) persistentTopicsSetMaxUnackedMessagesOnSubscriptionBody

-- ^ 
type PersistentTopicsSetMessageTTLAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "messageTTL" :> QueryParam "messageTTL" Int :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetMessageTTLParameters = PersistentTopicsSetMessageTTLParameters
  { persistentTopicsSetMessageTTLTenant :: Text -- ^ 
  , persistentTopicsSetMessageTTLNamespace :: Text -- ^ 
  , persistentTopicsSetMessageTTLTopic :: Text -- ^ 
  , persistentTopicsSetMessageTTLMessageTTL :: Int -- ^ TTL in seconds for the specified topic
  , persistentTopicsSetMessageTTLIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetMessageTTLAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsSetMessageTTL :: PersistentTopicsSetMessageTTLParameters -> ClientM NoContent
persistentTopicsSetMessageTTL PersistentTopicsSetMessageTTLParameters {..} = client (Proxy :: Proxy PersistentTopicsSetMessageTTLAPI) (persistentTopicsSetMessageTTLTenant) (persistentTopicsSetMessageTTLNamespace) (persistentTopicsSetMessageTTLTopic) (Just persistentTopicsSetMessageTTLMessageTTL) (persistentTopicsSetMessageTTLIsGlobal) (persistentTopicsSetMessageTTLAuthoritative)

-- ^ 
type PersistentTopicsSetOffloadPoliciesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offloadPolicies" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] OffloadPoliciesImpl :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetOffloadPoliciesParameters = PersistentTopicsSetOffloadPoliciesParameters
  { persistentTopicsSetOffloadPoliciesTenant :: Text -- ^ 
  , persistentTopicsSetOffloadPoliciesNamespace :: Text -- ^ 
  , persistentTopicsSetOffloadPoliciesTopic :: Text -- ^ 
  , persistentTopicsSetOffloadPoliciesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetOffloadPoliciesIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetOffloadPoliciesBody :: OffloadPoliciesImpl -- ^ Offload policies for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetOffloadPolicies :: PersistentTopicsSetOffloadPoliciesParameters -> ClientM NoContent
persistentTopicsSetOffloadPolicies PersistentTopicsSetOffloadPoliciesParameters {..} = client (Proxy :: Proxy PersistentTopicsSetOffloadPoliciesAPI) (persistentTopicsSetOffloadPoliciesTenant) (persistentTopicsSetOffloadPoliciesNamespace) (persistentTopicsSetOffloadPoliciesTopic) (persistentTopicsSetOffloadPoliciesAuthoritative) (persistentTopicsSetOffloadPoliciesIsGlobal) persistentTopicsSetOffloadPoliciesBody

-- ^ 
type PersistentTopicsSetPersistenceAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "persistence" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] PersistencePolicies :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetPersistenceParameters = PersistentTopicsSetPersistenceParameters
  { persistentTopicsSetPersistenceTenant :: Text -- ^ 
  , persistentTopicsSetPersistenceNamespace :: Text -- ^ 
  , persistentTopicsSetPersistenceTopic :: Text -- ^ 
  , persistentTopicsSetPersistenceAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetPersistenceIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetPersistenceBody :: PersistencePolicies -- ^ Bookkeeper persistence policies for specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetPersistence :: PersistentTopicsSetPersistenceParameters -> ClientM NoContent
persistentTopicsSetPersistence PersistentTopicsSetPersistenceParameters {..} = client (Proxy :: Proxy PersistentTopicsSetPersistenceAPI) (persistentTopicsSetPersistenceTenant) (persistentTopicsSetPersistenceNamespace) (persistentTopicsSetPersistenceTopic) (persistentTopicsSetPersistenceAuthoritative) (persistentTopicsSetPersistenceIsGlobal) persistentTopicsSetPersistenceBody

-- ^ 
type PersistentTopicsSetPublishRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "publishRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] PublishRate :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetPublishRateParameters = PersistentTopicsSetPublishRateParameters
  { persistentTopicsSetPublishRateTenant :: Text -- ^ 
  , persistentTopicsSetPublishRateNamespace :: Text -- ^ 
  , persistentTopicsSetPublishRateTopic :: Text -- ^ 
  , persistentTopicsSetPublishRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetPublishRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetPublishRateBody :: PublishRate -- ^ Dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetPublishRate :: PersistentTopicsSetPublishRateParameters -> ClientM NoContent
persistentTopicsSetPublishRate PersistentTopicsSetPublishRateParameters {..} = client (Proxy :: Proxy PersistentTopicsSetPublishRateAPI) (persistentTopicsSetPublishRateTenant) (persistentTopicsSetPublishRateNamespace) (persistentTopicsSetPublishRateTopic) (persistentTopicsSetPublishRateIsGlobal) (persistentTopicsSetPublishRateAuthoritative) persistentTopicsSetPublishRateBody

-- ^ 
type PersistentTopicsSetReplicatedSubscriptionStatusAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "replicatedSubscriptionStatus" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetReplicatedSubscriptionStatusParameters = PersistentTopicsSetReplicatedSubscriptionStatusParameters
  { persistentTopicsSetReplicatedSubscriptionStatusTenant :: Text -- ^ Specify the tenant
  , persistentTopicsSetReplicatedSubscriptionStatusNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsSetReplicatedSubscriptionStatusTopic :: Text -- ^ Specify topic name
  , persistentTopicsSetReplicatedSubscriptionStatusSubName :: Text -- ^ Name of subscription
  , persistentTopicsSetReplicatedSubscriptionStatusBody :: Bool -- ^ Whether to enable replicated subscription
  , persistentTopicsSetReplicatedSubscriptionStatusAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsSetReplicatedSubscriptionStatus :: PersistentTopicsSetReplicatedSubscriptionStatusParameters -> ClientM NoContent
persistentTopicsSetReplicatedSubscriptionStatus PersistentTopicsSetReplicatedSubscriptionStatusParameters {..} = client (Proxy :: Proxy PersistentTopicsSetReplicatedSubscriptionStatusAPI) (persistentTopicsSetReplicatedSubscriptionStatusTenant) (persistentTopicsSetReplicatedSubscriptionStatusNamespace) (persistentTopicsSetReplicatedSubscriptionStatusTopic) (persistentTopicsSetReplicatedSubscriptionStatusSubName) (persistentTopicsSetReplicatedSubscriptionStatusAuthoritative) persistentTopicsSetReplicatedSubscriptionStatusBody

-- ^ 
type PersistentTopicsSetReplicationClustersAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replication" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetReplicationClustersParameters = PersistentTopicsSetReplicationClustersParameters
  { persistentTopicsSetReplicationClustersTenant :: Text -- ^ 
  , persistentTopicsSetReplicationClustersNamespace :: Text -- ^ 
  , persistentTopicsSetReplicationClustersTopic :: Text -- ^ 
  , persistentTopicsSetReplicationClustersBody :: [Text] -- ^ List of replication clusters
  , persistentTopicsSetReplicationClustersIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetReplicationClustersAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsSetReplicationClusters :: PersistentTopicsSetReplicationClustersParameters -> ClientM NoContent
persistentTopicsSetReplicationClusters PersistentTopicsSetReplicationClustersParameters {..} = client (Proxy :: Proxy PersistentTopicsSetReplicationClustersAPI) (persistentTopicsSetReplicationClustersTenant) (persistentTopicsSetReplicationClustersNamespace) (persistentTopicsSetReplicationClustersTopic) (persistentTopicsSetReplicationClustersIsGlobal) (persistentTopicsSetReplicationClustersAuthoritative) persistentTopicsSetReplicationClustersBody

-- ^ 
type PersistentTopicsSetReplicatorDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "replicatorDispatchRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetReplicatorDispatchRateParameters = PersistentTopicsSetReplicatorDispatchRateParameters
  { persistentTopicsSetReplicatorDispatchRateTenant :: Text -- ^ 
  , persistentTopicsSetReplicatorDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsSetReplicatorDispatchRateTopic :: Text -- ^ 
  , persistentTopicsSetReplicatorDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetReplicatorDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetReplicatorDispatchRateBody :: DispatchRateImpl -- ^ Replicator dispatch rate of the topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetReplicatorDispatchRate :: PersistentTopicsSetReplicatorDispatchRateParameters -> ClientM NoContent
persistentTopicsSetReplicatorDispatchRate PersistentTopicsSetReplicatorDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsSetReplicatorDispatchRateAPI) (persistentTopicsSetReplicatorDispatchRateTenant) (persistentTopicsSetReplicatorDispatchRateNamespace) (persistentTopicsSetReplicatorDispatchRateTopic) (persistentTopicsSetReplicatorDispatchRateIsGlobal) (persistentTopicsSetReplicatorDispatchRateAuthoritative) persistentTopicsSetReplicatorDispatchRateBody

-- ^ 
type PersistentTopicsSetRetentionAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "retention" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] RetentionPolicies :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetRetentionParameters = PersistentTopicsSetRetentionParameters
  { persistentTopicsSetRetentionTenant :: Text -- ^ 
  , persistentTopicsSetRetentionNamespace :: Text -- ^ 
  , persistentTopicsSetRetentionTopic :: Text -- ^ 
  , persistentTopicsSetRetentionAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetRetentionIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetRetentionBody :: RetentionPolicies -- ^ Retention policies for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetRetention :: PersistentTopicsSetRetentionParameters -> ClientM NoContent
persistentTopicsSetRetention PersistentTopicsSetRetentionParameters {..} = client (Proxy :: Proxy PersistentTopicsSetRetentionAPI) (persistentTopicsSetRetentionTenant) (persistentTopicsSetRetentionNamespace) (persistentTopicsSetRetentionTopic) (persistentTopicsSetRetentionAuthoritative) (persistentTopicsSetRetentionIsGlobal) persistentTopicsSetRetentionBody

-- ^ 
type PersistentTopicsSetSchemaCompatibilityStrategyAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaCompatibilityStrategy" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Text :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsSetSchemaCompatibilityStrategyParameters = PersistentTopicsSetSchemaCompatibilityStrategyParameters
  { persistentTopicsSetSchemaCompatibilityStrategyTenant :: Text -- ^ Specify the tenant
  , persistentTopicsSetSchemaCompatibilityStrategyNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsSetSchemaCompatibilityStrategyTopic :: Text -- ^ Specify topic name
  , persistentTopicsSetSchemaCompatibilityStrategyAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetSchemaCompatibilityStrategyBody :: Text -- ^ Strategy used to check the compatibility of new schema
  } deriving (Show, Eq, Generic)

persistentTopicsSetSchemaCompatibilityStrategy :: PersistentTopicsSetSchemaCompatibilityStrategyParameters -> ClientM NoContent
persistentTopicsSetSchemaCompatibilityStrategy PersistentTopicsSetSchemaCompatibilityStrategyParameters {..} = client (Proxy :: Proxy PersistentTopicsSetSchemaCompatibilityStrategyAPI) (persistentTopicsSetSchemaCompatibilityStrategyTenant) (persistentTopicsSetSchemaCompatibilityStrategyNamespace) (persistentTopicsSetSchemaCompatibilityStrategyTopic) (persistentTopicsSetSchemaCompatibilityStrategyAuthoritative) persistentTopicsSetSchemaCompatibilityStrategyBody

-- ^ 
type PersistentTopicsSetSchemaValidationEnforcedAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemaValidationEnforced" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetSchemaValidationEnforcedParameters = PersistentTopicsSetSchemaValidationEnforcedParameters
  { persistentTopicsSetSchemaValidationEnforcedTenant :: Text -- ^ Specify the tenant
  , persistentTopicsSetSchemaValidationEnforcedNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsSetSchemaValidationEnforcedTopic :: Text -- ^ Specify topic name
  , persistentTopicsSetSchemaValidationEnforcedBody :: Bool -- ^ 
  , persistentTopicsSetSchemaValidationEnforcedAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsSetSchemaValidationEnforced :: PersistentTopicsSetSchemaValidationEnforcedParameters -> ClientM NoContent
persistentTopicsSetSchemaValidationEnforced PersistentTopicsSetSchemaValidationEnforcedParameters {..} = client (Proxy :: Proxy PersistentTopicsSetSchemaValidationEnforcedAPI) (persistentTopicsSetSchemaValidationEnforcedTenant) (persistentTopicsSetSchemaValidationEnforcedNamespace) (persistentTopicsSetSchemaValidationEnforcedTopic) (persistentTopicsSetSchemaValidationEnforcedAuthoritative) persistentTopicsSetSchemaValidationEnforcedBody

-- ^ 
type PersistentTopicsSetShadowTopicsAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "shadowTopics" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] [Text] :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsSetShadowTopicsParameters = PersistentTopicsSetShadowTopicsParameters
  { persistentTopicsSetShadowTopicsTenant :: Text -- ^ 
  , persistentTopicsSetShadowTopicsNamespace :: Text -- ^ 
  , persistentTopicsSetShadowTopicsTopic :: Text -- ^ 
  , persistentTopicsSetShadowTopicsBody :: [Text] -- ^ List of shadow topics
  , persistentTopicsSetShadowTopicsAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsSetShadowTopics :: PersistentTopicsSetShadowTopicsParameters -> ClientM NoContent
persistentTopicsSetShadowTopics PersistentTopicsSetShadowTopicsParameters {..} = client (Proxy :: Proxy PersistentTopicsSetShadowTopicsAPI) (persistentTopicsSetShadowTopicsTenant) (persistentTopicsSetShadowTopicsNamespace) (persistentTopicsSetShadowTopicsTopic) (persistentTopicsSetShadowTopicsAuthoritative) persistentTopicsSetShadowTopicsBody

-- ^ 
type PersistentTopicsSetSubscribeRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscribeRate" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] SubscribeRate :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetSubscribeRateParameters = PersistentTopicsSetSubscribeRateParameters
  { persistentTopicsSetSubscribeRateTenant :: Text -- ^ 
  , persistentTopicsSetSubscribeRateNamespace :: Text -- ^ 
  , persistentTopicsSetSubscribeRateTopic :: Text -- ^ 
  , persistentTopicsSetSubscribeRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetSubscribeRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetSubscribeRateBody :: SubscribeRate -- ^ Subscribe rate for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetSubscribeRate :: PersistentTopicsSetSubscribeRateParameters -> ClientM NoContent
persistentTopicsSetSubscribeRate PersistentTopicsSetSubscribeRateParameters {..} = client (Proxy :: Proxy PersistentTopicsSetSubscribeRateAPI) (persistentTopicsSetSubscribeRateTenant) (persistentTopicsSetSubscribeRateNamespace) (persistentTopicsSetSubscribeRateTopic) (persistentTopicsSetSubscribeRateIsGlobal) (persistentTopicsSetSubscribeRateAuthoritative) persistentTopicsSetSubscribeRateBody

-- ^ 
type PersistentTopicsSetSubscriptionDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionDispatchRate" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetSubscriptionDispatchRateParameters = PersistentTopicsSetSubscriptionDispatchRateParameters
  { persistentTopicsSetSubscriptionDispatchRateTenant :: Text -- ^ 
  , persistentTopicsSetSubscriptionDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsSetSubscriptionDispatchRateTopic :: Text -- ^ 
  , persistentTopicsSetSubscriptionDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetSubscriptionDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetSubscriptionDispatchRateBody :: DispatchRateImpl -- ^ Subscription message dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetSubscriptionDispatchRate :: PersistentTopicsSetSubscriptionDispatchRateParameters -> ClientM NoContent
persistentTopicsSetSubscriptionDispatchRate PersistentTopicsSetSubscriptionDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsSetSubscriptionDispatchRateAPI) (persistentTopicsSetSubscriptionDispatchRateTenant) (persistentTopicsSetSubscriptionDispatchRateNamespace) (persistentTopicsSetSubscriptionDispatchRateTopic) (persistentTopicsSetSubscriptionDispatchRateAuthoritative) (persistentTopicsSetSubscriptionDispatchRateIsGlobal) persistentTopicsSetSubscriptionDispatchRateBody

-- ^ 
type PersistentTopicsSetSubscriptionLevelDispatchRateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> Capture "subName" Text :> "dispatchRate" :> QueryParam "authoritative" Bool :> QueryParam "isGlobal" Bool :> ReqBody '[JSON] DispatchRateImpl :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetSubscriptionLevelDispatchRateParameters = PersistentTopicsSetSubscriptionLevelDispatchRateParameters
  { persistentTopicsSetSubscriptionLevelDispatchRateTenant :: Text -- ^ 
  , persistentTopicsSetSubscriptionLevelDispatchRateNamespace :: Text -- ^ 
  , persistentTopicsSetSubscriptionLevelDispatchRateTopic :: Text -- ^ 
  , persistentTopicsSetSubscriptionLevelDispatchRateSubName :: Text -- ^ 
  , persistentTopicsSetSubscriptionLevelDispatchRateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetSubscriptionLevelDispatchRateIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetSubscriptionLevelDispatchRateBody :: DispatchRateImpl -- ^ Subscription message dispatch rate for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetSubscriptionLevelDispatchRate :: PersistentTopicsSetSubscriptionLevelDispatchRateParameters -> ClientM NoContent
persistentTopicsSetSubscriptionLevelDispatchRate PersistentTopicsSetSubscriptionLevelDispatchRateParameters {..} = client (Proxy :: Proxy PersistentTopicsSetSubscriptionLevelDispatchRateAPI) (persistentTopicsSetSubscriptionLevelDispatchRateTenant) (persistentTopicsSetSubscriptionLevelDispatchRateNamespace) (persistentTopicsSetSubscriptionLevelDispatchRateTopic) (persistentTopicsSetSubscriptionLevelDispatchRateSubName) (persistentTopicsSetSubscriptionLevelDispatchRateAuthoritative) (persistentTopicsSetSubscriptionLevelDispatchRateIsGlobal) persistentTopicsSetSubscriptionLevelDispatchRateBody

-- ^ 
type PersistentTopicsSetSubscriptionTypesEnabledAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscriptionTypesEnabled" :> QueryParam "isGlobal" Bool :> QueryParam "authoritative" Bool :> ReqBody '[JSON] [Text] :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSetSubscriptionTypesEnabledParameters = PersistentTopicsSetSubscriptionTypesEnabledParameters
  { persistentTopicsSetSubscriptionTypesEnabledTenant :: Text -- ^ 
  , persistentTopicsSetSubscriptionTypesEnabledNamespace :: Text -- ^ 
  , persistentTopicsSetSubscriptionTypesEnabledTopic :: Text -- ^ 
  , persistentTopicsSetSubscriptionTypesEnabledIsGlobal :: Maybe Bool -- ^ 
  , persistentTopicsSetSubscriptionTypesEnabledAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsSetSubscriptionTypesEnabledBody :: [Text] -- ^ Enable sub types for the specified topic
  } deriving (Show, Eq, Generic)

persistentTopicsSetSubscriptionTypesEnabled :: PersistentTopicsSetSubscriptionTypesEnabledParameters -> ClientM NoContent
persistentTopicsSetSubscriptionTypesEnabled PersistentTopicsSetSubscriptionTypesEnabledParameters {..} = client (Proxy :: Proxy PersistentTopicsSetSubscriptionTypesEnabledAPI) (persistentTopicsSetSubscriptionTypesEnabledTenant) (persistentTopicsSetSubscriptionTypesEnabledNamespace) (persistentTopicsSetSubscriptionTypesEnabledTopic) (persistentTopicsSetSubscriptionTypesEnabledIsGlobal) (persistentTopicsSetSubscriptionTypesEnabledAuthoritative) persistentTopicsSetSubscriptionTypesEnabledBody

-- ^ Completely clears the backlog on the subscription.
type PersistentTopicsSkipAllMessagesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "skip_all" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSkipAllMessagesParameters = PersistentTopicsSkipAllMessagesParameters
  { persistentTopicsSkipAllMessagesTenant :: Text -- ^ Specify the tenant
  , persistentTopicsSkipAllMessagesNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsSkipAllMessagesTopic :: Text -- ^ Specify topic name
  , persistentTopicsSkipAllMessagesSubName :: Text -- ^ Name of subscription
  , persistentTopicsSkipAllMessagesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsSkipAllMessages :: PersistentTopicsSkipAllMessagesParameters -> ClientM NoContent
persistentTopicsSkipAllMessages PersistentTopicsSkipAllMessagesParameters {..} = client (Proxy :: Proxy PersistentTopicsSkipAllMessagesAPI) (persistentTopicsSkipAllMessagesTenant) (persistentTopicsSkipAllMessagesNamespace) (persistentTopicsSkipAllMessagesTopic) (persistentTopicsSkipAllMessagesSubName) (persistentTopicsSkipAllMessagesAuthoritative)

-- ^ 
type PersistentTopicsSkipMessagesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "skip" :> Capture "numMessages" Int :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsSkipMessagesParameters = PersistentTopicsSkipMessagesParameters
  { persistentTopicsSkipMessagesTenant :: Text -- ^ Specify the tenant
  , persistentTopicsSkipMessagesNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsSkipMessagesTopic :: Text -- ^ Specify topic name
  , persistentTopicsSkipMessagesSubName :: Text -- ^ Name of subscription
  , persistentTopicsSkipMessagesNumMessages :: Int -- ^ The number of messages to skip
  , persistentTopicsSkipMessagesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsSkipMessages :: PersistentTopicsSkipMessagesParameters -> ClientM NoContent
persistentTopicsSkipMessages PersistentTopicsSkipMessagesParameters {..} = client (Proxy :: Proxy PersistentTopicsSkipMessagesAPI) (persistentTopicsSkipMessagesTenant) (persistentTopicsSkipMessagesNamespace) (persistentTopicsSkipMessagesTopic) (persistentTopicsSkipMessagesSubName) (persistentTopicsSkipMessagesNumMessages) (persistentTopicsSkipMessagesAuthoritative)

-- ^ 
type PersistentTopicsTerminateAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "terminate" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] MessageIdAdv

data PersistentTopicsTerminateParameters = PersistentTopicsTerminateParameters
  { persistentTopicsTerminateTenant :: Text -- ^ Specify the tenant
  , persistentTopicsTerminateNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsTerminateTopic :: Text -- ^ Specify topic name
  , persistentTopicsTerminateAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsTerminate :: PersistentTopicsTerminateParameters -> ClientM MessageIdAdv
persistentTopicsTerminate PersistentTopicsTerminateParameters {..} = client (Proxy :: Proxy PersistentTopicsTerminateAPI) (persistentTopicsTerminateTenant) (persistentTopicsTerminateNamespace) (persistentTopicsTerminateTopic) (persistentTopicsTerminateAuthoritative)

-- ^ 
type PersistentTopicsTerminatePartitionedTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "terminate" :> "partitions" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsTerminatePartitionedTopicParameters = PersistentTopicsTerminatePartitionedTopicParameters
  { persistentTopicsTerminatePartitionedTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsTerminatePartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsTerminatePartitionedTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsTerminatePartitionedTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsTerminatePartitionedTopic :: PersistentTopicsTerminatePartitionedTopicParameters -> ClientM NoContent
persistentTopicsTerminatePartitionedTopic PersistentTopicsTerminatePartitionedTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsTerminatePartitionedTopicAPI) (persistentTopicsTerminatePartitionedTopicTenant) (persistentTopicsTerminatePartitionedTopicNamespace) (persistentTopicsTerminatePartitionedTopicTopic) (persistentTopicsTerminatePartitionedTopicAuthoritative)

-- ^ 
type PersistentTopicsTriggerOffloadAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "offload" :> QueryParam "authoritative" Bool :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsTriggerOffloadParameters = PersistentTopicsTriggerOffloadParameters
  { persistentTopicsTriggerOffloadTenant :: Text -- ^ Specify the tenant
  , persistentTopicsTriggerOffloadNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsTriggerOffloadTopic :: Text -- ^ Specify topic name
  , persistentTopicsTriggerOffloadAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsTriggerOffload :: PersistentTopicsTriggerOffloadParameters -> ClientM NoContent
persistentTopicsTriggerOffload PersistentTopicsTriggerOffloadParameters {..} = client (Proxy :: Proxy PersistentTopicsTriggerOffloadAPI) (persistentTopicsTriggerOffloadTenant) (persistentTopicsTriggerOffloadNamespace) (persistentTopicsTriggerOffloadTopic) (persistentTopicsTriggerOffloadAuthoritative)

-- ^ 
type PersistentTopicsTrimTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "trim" :> QueryParam "authoritative" Bool :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsTrimTopicParameters = PersistentTopicsTrimTopicParameters
  { persistentTopicsTrimTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsTrimTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsTrimTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsTrimTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsTrimTopic :: PersistentTopicsTrimTopicParameters -> ClientM NoContent
persistentTopicsTrimTopic PersistentTopicsTrimTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsTrimTopicAPI) (persistentTopicsTrimTopicTenant) (persistentTopicsTrimTopicNamespace) (persistentTopicsTrimTopicTopic) (persistentTopicsTrimTopicAuthoritative)

-- ^ The truncate operation will move all cursors to the end of the topic and delete all inactive ledgers.
type PersistentTopicsTruncateTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "truncate" :> QueryParam "authoritative" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data PersistentTopicsTruncateTopicParameters = PersistentTopicsTruncateTopicParameters
  { persistentTopicsTruncateTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsTruncateTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsTruncateTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsTruncateTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsTruncateTopic :: PersistentTopicsTruncateTopicParameters -> ClientM NoContent
persistentTopicsTruncateTopic PersistentTopicsTruncateTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsTruncateTopicAPI) (persistentTopicsTruncateTopicTenant) (persistentTopicsTruncateTopicNamespace) (persistentTopicsTruncateTopicTopic) (persistentTopicsTruncateTopicAuthoritative)

-- ^ 
type PersistentTopicsUnloadTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "unload" :> QueryParam "authoritative" Bool :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsUnloadTopicParameters = PersistentTopicsUnloadTopicParameters
  { persistentTopicsUnloadTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsUnloadTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsUnloadTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsUnloadTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  } deriving (Show, Eq, Generic)

persistentTopicsUnloadTopic :: PersistentTopicsUnloadTopicParameters -> ClientM NoContent
persistentTopicsUnloadTopic PersistentTopicsUnloadTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsUnloadTopicAPI) (persistentTopicsUnloadTopicTenant) (persistentTopicsUnloadTopicNamespace) (persistentTopicsUnloadTopicTopic) (persistentTopicsUnloadTopicAuthoritative)

-- ^ It increments partitions of existing partitioned-topic
type PersistentTopicsUpdatePartitionedTopicAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "partitions" :> QueryParam "updateLocalTopicOnly" Bool :> QueryParam "authoritative" Bool :> QueryParam "force" Bool :> ReqBody '[JSON] Int :> Verb 'POST 200 '[JSON] NoContent

data PersistentTopicsUpdatePartitionedTopicParameters = PersistentTopicsUpdatePartitionedTopicParameters
  { persistentTopicsUpdatePartitionedTopicTenant :: Text -- ^ Specify the tenant
  , persistentTopicsUpdatePartitionedTopicNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsUpdatePartitionedTopicTopic :: Text -- ^ Specify topic name
  , persistentTopicsUpdatePartitionedTopicBody :: Int -- ^ The number of partitions for the topic
  , persistentTopicsUpdatePartitionedTopicUpdateLocalTopicOnly :: Maybe Bool -- ^ 
  , persistentTopicsUpdatePartitionedTopicAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsUpdatePartitionedTopicForce :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

persistentTopicsUpdatePartitionedTopic :: PersistentTopicsUpdatePartitionedTopicParameters -> ClientM NoContent
persistentTopicsUpdatePartitionedTopic PersistentTopicsUpdatePartitionedTopicParameters {..} = client (Proxy :: Proxy PersistentTopicsUpdatePartitionedTopicAPI) (persistentTopicsUpdatePartitionedTopicTenant) (persistentTopicsUpdatePartitionedTopicNamespace) (persistentTopicsUpdatePartitionedTopicTopic) (persistentTopicsUpdatePartitionedTopicUpdateLocalTopicOnly) (persistentTopicsUpdatePartitionedTopicAuthoritative) (persistentTopicsUpdatePartitionedTopicForce) persistentTopicsUpdatePartitionedTopicBody

-- ^ 
type PersistentTopicsUpdatePropertiesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "properties" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] (Map.Map String Text) :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsUpdatePropertiesParameters = PersistentTopicsUpdatePropertiesParameters
  { persistentTopicsUpdatePropertiesTenant :: Text -- ^ Specify the tenant
  , persistentTopicsUpdatePropertiesNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsUpdatePropertiesTopic :: Text -- ^ Specify topic name
  , persistentTopicsUpdatePropertiesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsUpdatePropertiesBody :: (Map.Map String Text) -- ^ Key value pair properties for the topic metadata
  } deriving (Show, Eq, Generic)

persistentTopicsUpdateProperties :: PersistentTopicsUpdatePropertiesParameters -> ClientM NoContent
persistentTopicsUpdateProperties PersistentTopicsUpdatePropertiesParameters {..} = client (Proxy :: Proxy PersistentTopicsUpdatePropertiesAPI) (persistentTopicsUpdatePropertiesTenant) (persistentTopicsUpdatePropertiesNamespace) (persistentTopicsUpdatePropertiesTopic) (persistentTopicsUpdatePropertiesAuthoritative) persistentTopicsUpdatePropertiesBody

-- ^ 
type PersistentTopicsUpdateSubscriptionPropertiesAPI =
      "admin" :> "v2" :> "persistent" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "subscription" :> Capture "subName" Text :> "properties" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] (Map.Map String Text) :> Verb 'PUT 200 '[JSON] NoContent

data PersistentTopicsUpdateSubscriptionPropertiesParameters = PersistentTopicsUpdateSubscriptionPropertiesParameters
  { persistentTopicsUpdateSubscriptionPropertiesTenant :: Text -- ^ Specify the tenant
  , persistentTopicsUpdateSubscriptionPropertiesNamespace :: Text -- ^ Specify the namespace
  , persistentTopicsUpdateSubscriptionPropertiesTopic :: Text -- ^ Specify topic name
  , persistentTopicsUpdateSubscriptionPropertiesSubName :: Text -- ^ Subscription to update
  , persistentTopicsUpdateSubscriptionPropertiesAuthoritative :: Maybe Bool -- ^ Whether leader broker redirected this call to this broker. For internal use.
  , persistentTopicsUpdateSubscriptionPropertiesBody :: (Map.Map String Text) -- ^ The new properties
  } deriving (Show, Eq, Generic)

persistentTopicsUpdateSubscriptionProperties :: PersistentTopicsUpdateSubscriptionPropertiesParameters -> ClientM NoContent
persistentTopicsUpdateSubscriptionProperties PersistentTopicsUpdateSubscriptionPropertiesParameters {..} = client (Proxy :: Proxy PersistentTopicsUpdateSubscriptionPropertiesAPI) (persistentTopicsUpdateSubscriptionPropertiesTenant) (persistentTopicsUpdateSubscriptionPropertiesNamespace) (persistentTopicsUpdateSubscriptionPropertiesTopic) (persistentTopicsUpdateSubscriptionPropertiesSubName) (persistentTopicsUpdateSubscriptionPropertiesAuthoritative) persistentTopicsUpdateSubscriptionPropertiesBody

-- ^ 
type ResourceQuotasGetDefaultResourceQuotaAPI =
      "admin" :> "v2" :> "resource-quotas" :> Verb 'GET 200 '[JSON] [Text]

resourceQuotasGetDefaultResourceQuota :: ClientM [Text]
resourceQuotasGetDefaultResourceQuota = client (Proxy :: Proxy ResourceQuotasGetDefaultResourceQuotaAPI)

-- ^ 
type ResourceQuotasGetNamespaceBundleResourceQuotaAPI =
      "admin" :> "v2" :> "resource-quotas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> Verb 'GET 200 '[JSON] ResourceQuota

data ResourceQuotasGetNamespaceBundleResourceQuotaParameters = ResourceQuotasGetNamespaceBundleResourceQuotaParameters
  { resourceQuotasGetNamespaceBundleResourceQuotaTenant :: Text -- ^ Tenant name
  , resourceQuotasGetNamespaceBundleResourceQuotaNamespace :: Text -- ^ Namespace name within the specified tenant
  , resourceQuotasGetNamespaceBundleResourceQuotaBundle :: Text -- ^ Namespace bundle range
  } deriving (Show, Eq, Generic)

resourceQuotasGetNamespaceBundleResourceQuota :: ResourceQuotasGetNamespaceBundleResourceQuotaParameters -> ClientM ResourceQuota
resourceQuotasGetNamespaceBundleResourceQuota ResourceQuotasGetNamespaceBundleResourceQuotaParameters {..} = client (Proxy :: Proxy ResourceQuotasGetNamespaceBundleResourceQuotaAPI) (resourceQuotasGetNamespaceBundleResourceQuotaTenant) (resourceQuotasGetNamespaceBundleResourceQuotaNamespace) (resourceQuotasGetNamespaceBundleResourceQuotaBundle)

-- ^ 
type ResourceQuotasRemoveNamespaceBundleResourceQuotaAPI =
      "admin" :> "v2" :> "resource-quotas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> Verb 'DELETE 200 '[JSON] NoContent

data ResourceQuotasRemoveNamespaceBundleResourceQuotaParameters = ResourceQuotasRemoveNamespaceBundleResourceQuotaParameters
  { resourceQuotasRemoveNamespaceBundleResourceQuotaTenant :: Text -- ^ Tenant name
  , resourceQuotasRemoveNamespaceBundleResourceQuotaNamespace :: Text -- ^ Namespace name within the specified tenant
  , resourceQuotasRemoveNamespaceBundleResourceQuotaBundle :: Text -- ^ Namespace bundle range
  } deriving (Show, Eq, Generic)

resourceQuotasRemoveNamespaceBundleResourceQuota :: ResourceQuotasRemoveNamespaceBundleResourceQuotaParameters -> ClientM NoContent
resourceQuotasRemoveNamespaceBundleResourceQuota ResourceQuotasRemoveNamespaceBundleResourceQuotaParameters {..} = client (Proxy :: Proxy ResourceQuotasRemoveNamespaceBundleResourceQuotaAPI) (resourceQuotasRemoveNamespaceBundleResourceQuotaTenant) (resourceQuotasRemoveNamespaceBundleResourceQuotaNamespace) (resourceQuotasRemoveNamespaceBundleResourceQuotaBundle)

-- ^ 
type ResourceQuotasSetDefaultResourceQuotaAPI =
      "admin" :> "v2" :> "resource-quotas" :> ReqBody '[JSON] ResourceQuota :> Verb 'POST 200 '[JSON] [Text]

data ResourceQuotasSetDefaultResourceQuotaParameters = ResourceQuotasSetDefaultResourceQuotaParameters
  { resourceQuotasSetDefaultResourceQuotaBody :: ResourceQuota -- ^ Default resource quota
  } deriving (Show, Eq, Generic)

resourceQuotasSetDefaultResourceQuota :: ResourceQuotasSetDefaultResourceQuotaParameters -> ClientM [Text]
resourceQuotasSetDefaultResourceQuota ResourceQuotasSetDefaultResourceQuotaParameters {..} = client (Proxy :: Proxy ResourceQuotasSetDefaultResourceQuotaAPI) resourceQuotasSetDefaultResourceQuotaBody

-- ^ 
type ResourceQuotasSetNamespaceBundleResourceQuotaAPI =
      "admin" :> "v2" :> "resource-quotas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "bundle" Text :> ReqBody '[JSON] ResourceQuota :> Verb 'POST 200 '[JSON] NoContent

data ResourceQuotasSetNamespaceBundleResourceQuotaParameters = ResourceQuotasSetNamespaceBundleResourceQuotaParameters
  { resourceQuotasSetNamespaceBundleResourceQuotaTenant :: Text -- ^ Tenant name
  , resourceQuotasSetNamespaceBundleResourceQuotaNamespace :: Text -- ^ Namespace name within the specified tenant
  , resourceQuotasSetNamespaceBundleResourceQuotaBundle :: Text -- ^ Namespace bundle range
  , resourceQuotasSetNamespaceBundleResourceQuotaBody :: ResourceQuota -- ^ Resource quota for the specified namespace
  } deriving (Show, Eq, Generic)

resourceQuotasSetNamespaceBundleResourceQuota :: ResourceQuotasSetNamespaceBundleResourceQuotaParameters -> ClientM NoContent
resourceQuotasSetNamespaceBundleResourceQuota ResourceQuotasSetNamespaceBundleResourceQuotaParameters {..} = client (Proxy :: Proxy ResourceQuotasSetNamespaceBundleResourceQuotaAPI) (resourceQuotasSetNamespaceBundleResourceQuotaTenant) (resourceQuotasSetNamespaceBundleResourceQuotaNamespace) (resourceQuotasSetNamespaceBundleResourceQuotaBundle) resourceQuotasSetNamespaceBundleResourceQuotaBody

-- ^ 
type ResourceGroupsCreateOrUpdateResourceGroupAPI =
      "admin" :> "v2" :> "resourcegroups" :> Capture "resourcegroup" Text :> ReqBody '[JSON] ResourceGroup :> Verb 'PUT 200 '[JSON] NoContent

data ResourceGroupsCreateOrUpdateResourceGroupParameters = ResourceGroupsCreateOrUpdateResourceGroupParameters
  { resourceGroupsCreateOrUpdateResourceGroupResourcegroup :: Text -- ^ 
  , resourceGroupsCreateOrUpdateResourceGroupBody :: ResourceGroup -- ^ Rate limiters for the resourcegroup
  } deriving (Show, Eq, Generic)

resourceGroupsCreateOrUpdateResourceGroup :: ResourceGroupsCreateOrUpdateResourceGroupParameters -> ClientM NoContent
resourceGroupsCreateOrUpdateResourceGroup ResourceGroupsCreateOrUpdateResourceGroupParameters {..} = client (Proxy :: Proxy ResourceGroupsCreateOrUpdateResourceGroupAPI) (resourceGroupsCreateOrUpdateResourceGroupResourcegroup) resourceGroupsCreateOrUpdateResourceGroupBody

-- ^ 
type ResourceGroupsDeleteResourceGroupAPI =
      "admin" :> "v2" :> "resourcegroups" :> Capture "resourcegroup" Text :> Verb 'DELETE 200 '[JSON] NoContent

data ResourceGroupsDeleteResourceGroupParameters = ResourceGroupsDeleteResourceGroupParameters
  { resourceGroupsDeleteResourceGroupResourcegroup :: Text -- ^ 
  } deriving (Show, Eq, Generic)

resourceGroupsDeleteResourceGroup :: ResourceGroupsDeleteResourceGroupParameters -> ClientM NoContent
resourceGroupsDeleteResourceGroup ResourceGroupsDeleteResourceGroupParameters {..} = client (Proxy :: Proxy ResourceGroupsDeleteResourceGroupAPI) (resourceGroupsDeleteResourceGroupResourcegroup)

-- ^ 
type ResourceGroupsGetResourceGroupAPI =
      "admin" :> "v2" :> "resourcegroups" :> Capture "resourcegroup" Text :> Verb 'GET 200 '[JSON] ResourceGroup

data ResourceGroupsGetResourceGroupParameters = ResourceGroupsGetResourceGroupParameters
  { resourceGroupsGetResourceGroupResourcegroup :: Text -- ^ 
  } deriving (Show, Eq, Generic)

resourceGroupsGetResourceGroup :: ResourceGroupsGetResourceGroupParameters -> ClientM ResourceGroup
resourceGroupsGetResourceGroup ResourceGroupsGetResourceGroupParameters {..} = client (Proxy :: Proxy ResourceGroupsGetResourceGroupAPI) (resourceGroupsGetResourceGroupResourcegroup)

-- ^ 
type ResourceGroupsGetResourceGroupsAPI =
      "admin" :> "v2" :> "resourcegroups" :> Verb 'GET 200 '[JSON] [Text]

resourceGroupsGetResourceGroups :: ClientM [Text]
resourceGroupsGetResourceGroups = client (Proxy :: Proxy ResourceGroupsGetResourceGroupsAPI)

-- ^ 
type SchemasResourceDeleteSchemaAPI =
      "admin" :> "v2" :> "schemas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schema" :> QueryParam "authoritative" Bool :> QueryParam "force" Bool :> Verb 'DELETE 200 '[JSON] DeleteSchemaResponse

data SchemasResourceDeleteSchemaParameters = SchemasResourceDeleteSchemaParameters
  { schemasResourceDeleteSchemaTenant :: Text -- ^ 
  , schemasResourceDeleteSchemaNamespace :: Text -- ^ 
  , schemasResourceDeleteSchemaTopic :: Text -- ^ 
  , schemasResourceDeleteSchemaAuthoritative :: Maybe Bool -- ^ 
  , schemasResourceDeleteSchemaForce :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

schemasResourceDeleteSchema :: SchemasResourceDeleteSchemaParameters -> ClientM DeleteSchemaResponse
schemasResourceDeleteSchema SchemasResourceDeleteSchemaParameters {..} = client (Proxy :: Proxy SchemasResourceDeleteSchemaAPI) (schemasResourceDeleteSchemaTenant) (schemasResourceDeleteSchemaNamespace) (schemasResourceDeleteSchemaTopic) (schemasResourceDeleteSchemaAuthoritative) (schemasResourceDeleteSchemaForce)

-- ^ 
type SchemasResourceGetAllSchemasAPI =
      "admin" :> "v2" :> "schemas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schemas" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] GetAllVersionsSchemaResponse

data SchemasResourceGetAllSchemasParameters = SchemasResourceGetAllSchemasParameters
  { schemasResourceGetAllSchemasTenant :: Text -- ^ 
  , schemasResourceGetAllSchemasNamespace :: Text -- ^ 
  , schemasResourceGetAllSchemasTopic :: Text -- ^ 
  , schemasResourceGetAllSchemasAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

schemasResourceGetAllSchemas :: SchemasResourceGetAllSchemasParameters -> ClientM GetAllVersionsSchemaResponse
schemasResourceGetAllSchemas SchemasResourceGetAllSchemasParameters {..} = client (Proxy :: Proxy SchemasResourceGetAllSchemasAPI) (schemasResourceGetAllSchemasTenant) (schemasResourceGetAllSchemasNamespace) (schemasResourceGetAllSchemasTopic) (schemasResourceGetAllSchemasAuthoritative)

-- ^ 
type SchemasResourceGetSchemaAPI =
      "admin" :> "v2" :> "schemas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schema" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] GetSchemaResponse

data SchemasResourceGetSchemaParameters = SchemasResourceGetSchemaParameters
  { schemasResourceGetSchemaTenant :: Text -- ^ 
  , schemasResourceGetSchemaNamespace :: Text -- ^ 
  , schemasResourceGetSchemaTopic :: Text -- ^ 
  , schemasResourceGetSchemaAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

schemasResourceGetSchema :: SchemasResourceGetSchemaParameters -> ClientM GetSchemaResponse
schemasResourceGetSchema SchemasResourceGetSchemaParameters {..} = client (Proxy :: Proxy SchemasResourceGetSchemaAPI) (schemasResourceGetSchemaTenant) (schemasResourceGetSchemaNamespace) (schemasResourceGetSchemaTopic) (schemasResourceGetSchemaAuthoritative)

-- ^ 
type SchemasResourceGetSchemaByVersionAPI =
      "admin" :> "v2" :> "schemas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schema" :> Capture "version" Text :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] GetSchemaResponse

data SchemasResourceGetSchemaByVersionParameters = SchemasResourceGetSchemaByVersionParameters
  { schemasResourceGetSchemaByVersionTenant :: Text -- ^ 
  , schemasResourceGetSchemaByVersionNamespace :: Text -- ^ 
  , schemasResourceGetSchemaByVersionTopic :: Text -- ^ 
  , schemasResourceGetSchemaByVersionVersion :: Text -- ^ 
  , schemasResourceGetSchemaByVersionAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

schemasResourceGetSchemaByVersion :: SchemasResourceGetSchemaByVersionParameters -> ClientM GetSchemaResponse
schemasResourceGetSchemaByVersion SchemasResourceGetSchemaByVersionParameters {..} = client (Proxy :: Proxy SchemasResourceGetSchemaByVersionAPI) (schemasResourceGetSchemaByVersionTenant) (schemasResourceGetSchemaByVersionNamespace) (schemasResourceGetSchemaByVersionTopic) (schemasResourceGetSchemaByVersionVersion) (schemasResourceGetSchemaByVersionAuthoritative)

-- ^ 
type SchemasResourceGetSchemaMetadataAPI =
      "admin" :> "v2" :> "schemas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "metadata" :> QueryParam "authoritative" Bool :> Verb 'GET 200 '[JSON] GetAllVersionsSchemaResponse

data SchemasResourceGetSchemaMetadataParameters = SchemasResourceGetSchemaMetadataParameters
  { schemasResourceGetSchemaMetadataTenant :: Text -- ^ 
  , schemasResourceGetSchemaMetadataNamespace :: Text -- ^ 
  , schemasResourceGetSchemaMetadataTopic :: Text -- ^ 
  , schemasResourceGetSchemaMetadataAuthoritative :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

schemasResourceGetSchemaMetadata :: SchemasResourceGetSchemaMetadataParameters -> ClientM GetAllVersionsSchemaResponse
schemasResourceGetSchemaMetadata SchemasResourceGetSchemaMetadataParameters {..} = client (Proxy :: Proxy SchemasResourceGetSchemaMetadataAPI) (schemasResourceGetSchemaMetadataTenant) (schemasResourceGetSchemaMetadataNamespace) (schemasResourceGetSchemaMetadataTopic) (schemasResourceGetSchemaMetadataAuthoritative)

-- ^ 
type SchemasResourceGetVersionBySchemaAPI =
      "admin" :> "v2" :> "schemas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "version" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] PostSchemaPayload :> Verb 'POST 200 '[JSON] LongSchemaVersion

data SchemasResourceGetVersionBySchemaParameters = SchemasResourceGetVersionBySchemaParameters
  { schemasResourceGetVersionBySchemaTenant :: Text -- ^ 
  , schemasResourceGetVersionBySchemaNamespace :: Text -- ^ 
  , schemasResourceGetVersionBySchemaTopic :: Text -- ^ 
  , schemasResourceGetVersionBySchemaAuthoritative :: Maybe Bool -- ^ 
  , schemasResourceGetVersionBySchemaBody :: PostSchemaPayload -- ^ A JSON value presenting a schema payload. An example of the expected schema can be found down here.
  } deriving (Show, Eq, Generic)

schemasResourceGetVersionBySchema :: SchemasResourceGetVersionBySchemaParameters -> ClientM LongSchemaVersion
schemasResourceGetVersionBySchema SchemasResourceGetVersionBySchemaParameters {..} = client (Proxy :: Proxy SchemasResourceGetVersionBySchemaAPI) (schemasResourceGetVersionBySchemaTenant) (schemasResourceGetVersionBySchemaNamespace) (schemasResourceGetVersionBySchemaTopic) (schemasResourceGetVersionBySchemaAuthoritative) schemasResourceGetVersionBySchemaBody

-- ^ 
type SchemasResourcePostSchemaAPI =
      "admin" :> "v2" :> "schemas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "schema" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] PostSchemaPayload :> Verb 'POST 200 '[JSON] PostSchemaResponse

data SchemasResourcePostSchemaParameters = SchemasResourcePostSchemaParameters
  { schemasResourcePostSchemaTenant :: Text -- ^ 
  , schemasResourcePostSchemaNamespace :: Text -- ^ 
  , schemasResourcePostSchemaTopic :: Text -- ^ 
  , schemasResourcePostSchemaAuthoritative :: Maybe Bool -- ^ 
  , schemasResourcePostSchemaBody :: PostSchemaPayload -- ^ A JSON value presenting a schema payload. An example of the expected schema can be found down here.
  } deriving (Show, Eq, Generic)

schemasResourcePostSchema :: SchemasResourcePostSchemaParameters -> ClientM PostSchemaResponse
schemasResourcePostSchema SchemasResourcePostSchemaParameters {..} = client (Proxy :: Proxy SchemasResourcePostSchemaAPI) (schemasResourcePostSchemaTenant) (schemasResourcePostSchemaNamespace) (schemasResourcePostSchemaTopic) (schemasResourcePostSchemaAuthoritative) schemasResourcePostSchemaBody

-- ^ 
type SchemasResourceTestCompatibilityAPI =
      "admin" :> "v2" :> "schemas" :> Capture "tenant" Text :> Capture "namespace" Text :> Capture "topic" Text :> "compatibility" :> QueryParam "authoritative" Bool :> ReqBody '[JSON] PostSchemaPayload :> Verb 'POST 200 '[JSON] IsCompatibilityResponse

data SchemasResourceTestCompatibilityParameters = SchemasResourceTestCompatibilityParameters
  { schemasResourceTestCompatibilityTenant :: Text -- ^ 
  , schemasResourceTestCompatibilityNamespace :: Text -- ^ 
  , schemasResourceTestCompatibilityTopic :: Text -- ^ 
  , schemasResourceTestCompatibilityAuthoritative :: Maybe Bool -- ^ 
  , schemasResourceTestCompatibilityBody :: PostSchemaPayload -- ^ A JSON value presenting a schema payload. An example of the expected schema can be found down here.
  } deriving (Show, Eq, Generic)

schemasResourceTestCompatibility :: SchemasResourceTestCompatibilityParameters -> ClientM IsCompatibilityResponse
schemasResourceTestCompatibility SchemasResourceTestCompatibilityParameters {..} = client (Proxy :: Proxy SchemasResourceTestCompatibilityAPI) (schemasResourceTestCompatibilityTenant) (schemasResourceTestCompatibilityNamespace) (schemasResourceTestCompatibilityTopic) (schemasResourceTestCompatibilityAuthoritative) schemasResourceTestCompatibilityBody

-- ^ This operation requires Pulsar super-user privileges.
type TenantsBaseCreateTenantAPI =
      "admin" :> "v2" :> "tenants" :> Capture "tenant" Text :> ReqBody '[JSON] TenantInfo :> Verb 'PUT 200 '[JSON] NoContent

data TenantsBaseCreateTenantParameters = TenantsBaseCreateTenantParameters
  { tenantsBaseCreateTenantTenant :: Text -- ^ The tenant name
  , tenantsBaseCreateTenantBody :: TenantInfo -- ^ TenantInfo
  } deriving (Show, Eq, Generic)

tenantsBaseCreateTenant :: TenantsBaseCreateTenantParameters -> ClientM NoContent
tenantsBaseCreateTenant TenantsBaseCreateTenantParameters {..} = client (Proxy :: Proxy TenantsBaseCreateTenantAPI) (tenantsBaseCreateTenantTenant) tenantsBaseCreateTenantBody

-- ^ 
type TenantsBaseDeleteTenantAPI =
      "admin" :> "v2" :> "tenants" :> Capture "tenant" Text :> QueryParam "force" Bool :> Verb 'DELETE 200 '[JSON] NoContent

data TenantsBaseDeleteTenantParameters = TenantsBaseDeleteTenantParameters
  { tenantsBaseDeleteTenantTenant :: Text -- ^ The tenant name
  , tenantsBaseDeleteTenantForce :: Maybe Bool -- ^ 
  } deriving (Show, Eq, Generic)

tenantsBaseDeleteTenant :: TenantsBaseDeleteTenantParameters -> ClientM NoContent
tenantsBaseDeleteTenant TenantsBaseDeleteTenantParameters {..} = client (Proxy :: Proxy TenantsBaseDeleteTenantAPI) (tenantsBaseDeleteTenantTenant) (tenantsBaseDeleteTenantForce)

-- ^ 
type TenantsBaseGetTenantAdminAPI =
      "admin" :> "v2" :> "tenants" :> Capture "tenant" Text :> Verb 'GET 200 '[JSON] TenantInfo

data TenantsBaseGetTenantAdminParameters = TenantsBaseGetTenantAdminParameters
  { tenantsBaseGetTenantAdminTenant :: Text -- ^ The tenant name
  } deriving (Show, Eq, Generic)

tenantsBaseGetTenantAdmin :: TenantsBaseGetTenantAdminParameters -> ClientM TenantInfo
tenantsBaseGetTenantAdmin TenantsBaseGetTenantAdminParameters {..} = client (Proxy :: Proxy TenantsBaseGetTenantAdminAPI) (tenantsBaseGetTenantAdminTenant)

-- ^ 
type TenantsBaseGetTenantsAPI =
      "admin" :> "v2" :> "tenants" :> Verb 'GET 200 '[JSON] [Text]

tenantsBaseGetTenants :: ClientM [Text]
tenantsBaseGetTenants = client (Proxy :: Proxy TenantsBaseGetTenantsAPI)

-- ^ This operation requires Pulsar super-user privileges.
type TenantsBaseUpdateTenantAPI =
      "admin" :> "v2" :> "tenants" :> Capture "tenant" Text :> ReqBody '[JSON] TenantInfo :> Verb 'POST 200 '[JSON] NoContent

data TenantsBaseUpdateTenantParameters = TenantsBaseUpdateTenantParameters
  { tenantsBaseUpdateTenantTenant :: Text -- ^ The tenant name
  , tenantsBaseUpdateTenantBody :: TenantInfo -- ^ TenantInfo
  } deriving (Show, Eq, Generic)

tenantsBaseUpdateTenant :: TenantsBaseUpdateTenantParameters -> ClientM NoContent
tenantsBaseUpdateTenant TenantsBaseUpdateTenantParameters {..} = client (Proxy :: Proxy TenantsBaseUpdateTenantAPI) (tenantsBaseUpdateTenantTenant) tenantsBaseUpdateTenantBody

